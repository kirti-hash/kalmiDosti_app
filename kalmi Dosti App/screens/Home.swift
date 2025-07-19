//
//  Home.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 06/06/25.
//

import SwiftData
import SwiftUI

struct ListItem: Identifiable {
    let id = UUID()
    let title: String
    let desc: String
    let image: String
}

struct Home: View {
    @Query var users: [User]
    @State private var username = ""
    @State private var password = ""
    @State private var selectedTab: FloatingBottomTabBar.Tab = .home
    @State private var goToEditProfile = false
    @State private var goToLogin = false
    @State private var showAlert = false
    @Environment(\.dismiss) var dismiss

    // var onLogout: () -> Void

    let items: [ListItem] = [
        ListItem(
            title: "Chatbot",
            desc: "Express yourself to AI companion – your trusted listener.",
            image: "chatbot"),
        ListItem(
            title: "Journal",
            desc:
                "Capture your thoughts, memories, and reflections in the diary.",
            image: "notebook"),
        ListItem(
            title: "Meditation",
            desc:
                "Boost your well-being  – whether it's stress or mental health, and stay fit.",
            image: "meditation"),
    ]

    @ViewBuilder
    func destinationView(for item: ListItem) -> some View {
        switch item.title {
        case "Chatbot":
            Chat()
        case "Journal":
            Diary()
        case "Meditation":
            Meditation()
        default:
            Text("Unknown destination")
        }
    }

    var body: some View {
        ZStack {
            Color.faceB5
                .ignoresSafeArea()

            VStack(spacing: 0) {

                let matchedUsers = users.filter {
                    $0.email
                        == UserDefaults.standard.string(
                            forKey: "loggedInEmail")
                }

                ZStack(alignment: .bottomLeading) {

                    Color.themeGreen
                        .frame(height: 179)
                        .cornerRadius(48, corners: [.bottomLeft, .bottomRight])

                    HStack(alignment: .center, spacing: 17) {

                        if selectedTab == .home {
                            // Check if imageData exists
                            if let currentUser = matchedUsers.first,
                                let imageData = currentUser.imageData,
                                let uiImage = UIImage(data: imageData)
                            {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 54, height: 54)
                                    .clipShape(Circle())
                            } else {
                                Image("user")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 54, height: 54)
                                    .clipShape(Circle())
                            }

                            if let currentUser = matchedUsers.first {
                                Text("Hi, \(currentUser.username)")
                                    .winkySans(
                                        size: 36, weight: 400, color: .black
                                    )
                            }
                        } else {
                            Spacer()
                            Text("Profile")
                                .winkySans(
                                    size: 36, weight: 400, color: .black
                                )
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom, 25)

                }

                VStack(spacing: 16) {

                    if selectedTab == .home {
                        Spacer()
                        ForEach(items) { item in
                            NavigationLink(
                                destination: destinationView(for: item)
                            ) {
                                HStack(spacing: 0) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("\(item.title)")
                                            .winkySans(
                                                size: 20, weight: 500,
                                                color: .black
                                            )
                                        Text("\(item.desc)")
                                            .winkySans(
                                                size: 10, weight: 300,
                                                color: .black
                                            )
                                            .padding(.trailing, 30)

                                    }
                                    Spacer()
                                    Image("\(item.image)")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)

                                }
                                .padding(25)
                                .frame(height: 123)
                                .background(Color.themeGreen.opacity(0.8))
                                .cornerRadius(25)
                                .shadow(radius: 3)
                                .padding(.horizontal, 32)
                            }

                        }

                    } else {
                        Spacer()
                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 8) {

                                if let currentUser = matchedUsers.first {

                                    Text("Name: \(currentUser.username)")
                                        .winkySans(
                                            size: 15, weight: 500, color: .black
                                        )
                                    Text("Email: \(currentUser.email)")
                                        .winkySans(
                                            size: 15, weight: 500, color: .black
                                        )
                                        .lineLimit(nil)  // allow unlimited lines
                                        .fixedSize(
                                            horizontal: false, vertical: true
                                        )  // wrap text properly
                                        .multilineTextAlignment(.leading)
                                        .padding(.trailing, 10)
                                }
                                Button(action: {
                                    // Handle action here (e.g., show modal, toggle view, etc.)
                                    print("Edit Profile tapped")
                                    goToEditProfile = true
                                }) {
                                    Text("Edit Profile")
                                        .winkySans(
                                            size: 15, weight: 400,
                                            color: .black
                                        )
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 12)
                                        .background(Color.faceB5)
                                        .clipShape(Capsule())
                                }
                                .padding(10)
                                .shadow(radius: 2)
                                .navigationDestination(
                                    isPresented: $goToEditProfile
                                ) {
                                    EditProfile()
                                    Text("")
                                        .hidden()
                                }

                                Button(action: {
                                    // Handle action here (e.g., show modal, toggle view, etc.)

                                    showAlert = true
                                }) {
                                    Text("Logout")
                                        .winkySans(
                                            size: 15, weight: 400,
                                            color: .black
                                        )
                                        .padding(.horizontal, 35)
                                        .padding(.vertical, 12)
                                        .background(Color.faceB5)
                                        .clipShape(Capsule())
                                }
                                .padding(5)
                                .shadow(radius: 2)
                                .navigationDestination(
                                    isPresented: $goToLogin
                                ) {
                                    Login()
                                    Text("")
                                        .hidden()
                                }

                                if showAlert {
                                    CustomAlertModal(
                                        image: Image("info"),
                                        title:
                                            "Are you sure you want to logout?",
                                        showCancelButton: true,
                                        onNo: { () -> Void in
                                            showAlert = false
                                        },
                                        onYes: { () -> Void in
                                            goToLogin = true
                                        },
                                        onOk: { () -> Void in
                                            print("ok")
                                        },
                                        onDismiss: { () -> Void in
                                            showAlert = false
                                        }
                                    )
                                }

                            }
                            Spacer()

                            // Check if imageData exists
                            if let currentUser = matchedUsers.first,
                                let imageData = currentUser.imageData,
                                let uiImage = UIImage(data: imageData)
                            {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                            } else {
                                Image("user")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                            }

                        }
                        .padding(25)
                        .frame(height: 223)
                        .background(Color.themeGreen.opacity(0.8))
                        .cornerRadius(25)
                        .shadow(radius: 3)
                        .padding(.horizontal, 32)

                    }

                    Spacer()
                    FloatingBottomTabBar(selectedTab: $selectedTab)

                }

            }.hideNavBar()
                .edgesIgnoringSafeArea(.top)
        }
        .onAppear {
            if users.isEmpty {
                print("🔍 No users found in SwiftData.")
            } else {
                print("✅ Found \(users.count) users in SwiftData.")
                for user in users {
                    print(
                        "🧑‍💻 User: \(user.username),\(user.email),\(user.password),\(user.id)"
                    )
                }
            }
        }
    }
}
