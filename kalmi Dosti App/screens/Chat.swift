//
//  Chat.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 17/06/25.
//

import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isCurrentUser: Bool
    let date: Date
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

struct Chat: View {

    @State private var messages: [ChatMessage] = [
        ChatMessage(
            text: "Hi!", isCurrentUser: false,
            date: Date().addingTimeInterval(-86400)),
        ChatMessage(
            text: "Hello!", isCurrentUser: true,
            date: Date().addingTimeInterval(-86400 + 60)),
        ChatMessage(
            text: "How are you?", isCurrentUser: false,
            date: Date().addingTimeInterval(-3600)),
        ChatMessage(text: "I’m great!", isCurrentUser: true, date: Date())
    ]

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
                    rightImage1: Image("more"),
                    rightImage2: Image("save"),
                    onBack: {
                        print("Back tapped")
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
                            }
                        }
                    }
                    .onChange(of: messages.count) { _ in
                        withAnimation {
                            proxy.scrollTo(messages.last?.id, anchor: .bottom)
                        }
                    }
                }

                ChatInputView(messageText: $messageText) {
                    sendMessage()
                }
            }
            
            if showDeleteChatModal {
                CustomModalView(
                    image: Image("info"),
                    title: "Do you want to delete your chat ?",
                    onDiscard: {
                        print("Discarded")
                        showDeleteChatModal = false
                    },
                    onSave: {
                        print("Saved")
                        showDeleteChatModal = false
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
        guard
            !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else { return }

        messages.append(
            ChatMessage(text: messageText, isCurrentUser: true, date: Date()))
        messageText = ""
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

