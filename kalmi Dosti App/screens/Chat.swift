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
                    
                    
                
                    
                    
                }

                ChatInputView(messageText: $messageText) {
                    sendMessage()
                }
            }
            .onAppear {
                


                
                if let user = user {
                    if user.chats.isEmpty {
                        let welcome = ChatMessageModel(
                            text: " \(user.username)!", isCurrentUser: false,
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
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    
                }
            }
        }
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
