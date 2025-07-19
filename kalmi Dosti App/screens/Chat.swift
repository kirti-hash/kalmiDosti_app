//
//  Chat.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 17/06/25.
//

import SwiftData
import SwiftUI

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isCurrentUser: Bool
    let date: Date
}

struct Chat: View {

    @State private var messages: [ChatMessage] = []
    @Query private var users: [User]  // assuming your model is `UserModel`
    var user: User? {
        users.first
    }
    @State private var isTyping = false
    @State private var messageText: String = ""
    @State private var showDeleteChatModal = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.faceB5
                .ignoresSafeArea()

            VStack {
                NavigationHeaderView(
                    title: "AI Friend",
                    showTitle: true,
                    showRightImage1: true,
                    showRightImage2: false,
                    rightImage1: Image("delete"),
                    rightImage2: Image("save"),
                    onBack: {
                        print("Back tapped")
                        if let user = user {
                            user.chats = messages.map {
                                ChatMessageModel(
                                    text: $0.text,
                                    isCurrentUser: $0.isCurrentUser,
                                    date: $0.date)
                            }
                        }
                        dismiss()
                    },
                    onRightImage1Tap: {
                        showDeleteChatModal = true

                    },
                    onRightImage2Tap: {
                        print("Gear tapped")

                    }
                )

                // Spacer()

                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            ForEach(groupedMessages(), id: \.key) {
                                date, messages in
                                DateSeparator(date: date)
                                    .frame(
                                        maxWidth: .infinity, alignment: .center)

                                ForEach(messages) { message in
                                    ChatBubble(message: message)
                                }
                                if isTyping {
                                    HStack {
                                        Spacer()
                                        VStack(alignment: .leading, spacing: 6)
                                        {
                                            HStack(spacing: 4) {
                                                Image(systemName: "ellipsis")
                                                    .font(.title2)
                                                    .foregroundColor(.gray)
                                                    .padding(10)
                                                    .background(
                                                        Color.gray.opacity(0.2)
                                                    )
                                                    .clipShape(Capsule())
                                                    .opacity(0.8)
                                                    .transition(.opacity)
                                            }
                                            Text(Date(), style: .time)
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                                .padding(
                                                    [.leading, .trailing], 8)
                                        }
                                    }
                                    .padding(.horizontal)
                                    .padding(.top, 2)
                                }

                            }
                        }
                    }
                    .onChange(of: messages) { _, _ in
                        if let lastID = messages.last?.id {
                            DispatchQueue.main.asyncAfter(
                                deadline: .now() + 0.05
                            ) {
                                withAnimation {
                                    proxy.scrollTo(lastID, anchor: .bottom)
                                }
                            }
                        }
                    }
                    //                    .onChange(of: messages.count) { oldmessage, newmessage in
                    //                        withAnimation {
                    //                            proxy.scrollTo(messages.last?.id, anchor: .bottom)
                    //                        }
                    //                    }
                }

                ChatInputView(messageText: $messageText) {
                    sendMessage()
                }
            }
            .onAppear {
                //                if messages.isEmpty, let userName = user?.username {
                //                    let welcome = "Hi, \(userName)!"
                //                    messages.append(
                //                        ChatMessage(
                //                            text: welcome, isCurrentUser: false, date: Date()))
                //                }

                if let user = user {
                    if user.chats.isEmpty {
                        let welcome = ChatMessageModel(
                            text: "Hi, \(user.username)!", isCurrentUser: false,
                            date: Date())
                        user.chats.append(welcome)
                        messages.append(
                            ChatMessage(
                                text: welcome.text,
                                isCurrentUser: welcome.isCurrentUser,
                                date: welcome.date))
                    } else {
                        messages = user.chats.map {
                            ChatMessage(
                                text: $0.text, isCurrentUser: $0.isCurrentUser,
                                date: $0.date)
                        }
                    }
                }
            }

            if showDeleteChatModal {
                CustomAlertModal(
                    image: Image("info"),
                    title: "Do you want to delete your chat ?",
                    showCancelButton: true,
                    onNo: {
                        print("no")
                        showDeleteChatModal = false
                    },
                    onYes: {
                        print("yes")
                        if let user = user {
                            if let welcome = user.chats.first {
                                user.chats = [welcome]
                                messages = [
                                    ChatMessage(
                                        text: welcome.text,
                                        isCurrentUser: welcome.isCurrentUser,
                                        date: welcome.date)
                                ]
                            } else {
                                user.chats = []
                                messages = []
                            }
                        }
                        showDeleteChatModal = false
                    },
                    onOk: {
                        print("ok")
                    },
                    onDismiss: {
                        showDeleteChatModal = false
                    }
                )
            }
        }.hideNavBar()

    }

    func groupedMessages() -> [(key: Date, value: [ChatMessage])] {
        let grouped = Dictionary(grouping: messages) { msg in
            Calendar.current.startOfDay(for: msg.date)
        }
        return grouped.sorted { $0.key < $1.key }
    }

    func sendMessage() {
        let trimmed = messageText.trimmingCharacters(
            in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let userMessage = ChatMessage(
            text: trimmed, isCurrentUser: true, date: Date())
        messages.append(userMessage)
        messageText = ""
        isTyping = true  // Start typing animation

        callHuggingFace(prompt: trimmed) { reply in
            print("✅ Full raw response:\n\(String(describing: reply))")
            DispatchQueue.main.async {
                isTyping = false  // Stop typing animation
                if let reply = reply {
                    let botMessage = ChatMessage(
                        text: reply, isCurrentUser: false, date: Date())
                    messages.append(botMessage)
                } else {
                    messages.append(
                        ChatMessage(
                            text: "Something went wrong.", isCurrentUser: false,
                            date: Date()))
                }
            }
        }
    }

    func callHuggingFace(
        prompt: String, completion: @escaping (String?) -> Void
    ) {
        guard
            let url = URL(
                string:
                    "https://router.huggingface.co/fireworks-ai/inference/v1/chat/completions"
            )
        else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(
            "Bearer \(Secrets.huggingFaceKey)",
            forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "model": "accounts/fireworks/models/deepseek-v3",
            "messages": [
                ["role": "user", "content": prompt]
            ],
            "max_tokens": 1000,
            "temperature": 0.7,
            "stream": false,
        ]

        do {
            request.httpBody = try JSONSerialization.data(
                withJSONObject: requestBody, options: [])
        } catch {
            print("❌ JSON encoding error: \(error)")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Network error: \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("❌ No data returned")
                completion(nil)
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data)
                    as? [String: Any],
                    let choices = json["choices"] as? [[String: Any]],
                    let message = choices.first?["message"] as? [String: Any],
                    let reply = message["content"] as? String
                {
                    completion(
                        reply)
                } else {
                    let raw =
                        String(data: data, encoding: .utf8)
                        ?? "No readable response"
                    print("❌ Unexpected format:\n\(raw)")
                    completion(nil)
                }
            } catch {
                let raw =
                    String(data: data, encoding: .utf8) ?? "No readable string"
                print("❌ JSON decoding error: \(error)\nRaw:\n\(raw)")
                completion(nil)
            }
        }.resume()
    }

}

struct ChatInputView: View {
    @Binding var messageText: String
    var onSend: () -> Void

    var body: some View {
        HStack(alignment: .bottom) {
            TextField(
                "Type Something...", text: $messageText, axis: .vertical
            )
            .lineLimit(1...6)
            .font(.custom("winkySans", size: 20).weight(.regular))
            .padding(.horizontal, 20)
            .scrollContentBackground(.hidden)
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(16)
            .scrollContentBackground(.hidden)

            Button(action: onSend) {
                Image("send")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                    .padding(.all, 8)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 2)
            }

        }
        .padding(.horizontal)

    }
}

struct ChatBubble: View {

    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isCurrentUser { Spacer() }

            VStack(
                alignment: message.isCurrentUser ? .trailing : .leading,
                spacing: 6
            ) {
                Text(message.text)
                    .padding()
                    .foregroundColor(message.isCurrentUser ? .black : .black)
                    .background(
                        message.isCurrentUser
                            ? Color.themeGreen : Color.gray.opacity(0.2)
                    )
                    .cornerRadius(16)
                    .frame(
                        maxWidth: UIScreen.main.bounds.width * 0.7,
                        alignment: message.isCurrentUser ? .trailing : .leading
                    )
                    .fixedSize(horizontal: false, vertical: true)

                Text(message.date, style: .time)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding([.leading, .trailing], 8)

            }

            if !message.isCurrentUser {
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.top, 2)

    }
}

struct DateSeparator: View {
    let date: Date

    var body: some View {
        Text(date, style: .date)
            .font(.caption)
            .padding(6)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(8)
            .padding(.vertical, 4)
    }
}
