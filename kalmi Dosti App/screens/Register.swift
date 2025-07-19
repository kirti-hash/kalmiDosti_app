//
//  Register.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 05/06/25.
//

import SwiftData
import SwiftUI

struct Register: View {

    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State private var confirmPassword = ""
    @State private var goToLogin = false
    @State private var goToHome = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.themeGreen, Color.faceB5]),
                startPoint: UnitPoint(x: 0.8, y: 0.5),
                endPoint: .topTrailing
            )
            .ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                Image("logo")
                    .resizable()
                    .frame(width: 220, height: 220)
                Text("create.your.account")
                    .winkySans(size: 15, weight: 400, color: .black)
                    .padding(.top, 13)

                VStack(spacing: 12) {
                    CustomTextField(
                        imageName: "username",
                        placeholder: "Username",
                        text: $username,
                        keyboardType: .default,
                        backgroundColor: Color.white65

                    )
                    CustomTextField(
                        imageName: "email",
                        placeholder: "Email",
                        text: $email,
                        keyboardType: .emailAddress,
                        backgroundColor: Color.white65

                    )
                    CustomTextField(
                        imageName: "password",
                        placeholder: "Password",
                        text: $password,
                        keyboardType: .default,
                        backgroundColor: Color.white65,
                        isPassword: true

                    )
                    CustomTextField(
                        imageName: "password",
                        placeholder: "Confirm.Password",
                        text: $confirmPassword,
                        keyboardType: .default,
                        backgroundColor: Color.white65,
                        isPassword: true

                    )

                }.padding(.top, 34)

                Text("by.registering")
                    .winkySans(size: 13, weight: 400, color: .black)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)

                Spacer()
                CustomButton(title: "Register", backgroundColor: .faceB5) {
                    // Check for empty fields
                    if username.isEmpty || password.isEmpty || email.isEmpty
                        || confirmPassword.isEmpty
                    {
                        alertMessage = "All fields are required."
                        showAlert = true
                        return
                    }

                    // Username validation (only letters and special characters)
                    let usernameRegex =
                        "^[A-Za-z!@#$%^&*()_+=\\[\\]{}|:;\"'<>,.?/-]+$"
                    if !NSPredicate(format: "SELF MATCHES %@", usernameRegex)
                        .evaluate(with: username)
                    {
                        alertMessage =
                            "Username can only contain alphabets and special characters."
                        showAlert = true
                        return
                    }

                    // Email validation
                    let emailRegex =
                        "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
                    if !NSPredicate(format: "SELF MATCHES %@", emailRegex)
                        .evaluate(with: email)
                    {
                        alertMessage = "Please enter a valid email address."
                        showAlert = true
                        return
                    }

                    // Password match
                    if password != confirmPassword {
                        alertMessage = "Passwords do not match."
                        showAlert = true
                        return
                    }

                    // ✅ Check if user already exists
                    let descriptor = FetchDescriptor<User>(
                        predicate: #Predicate { $0.email == email }
                    )

                    do {
                        let existingUsers = try modelContext.fetch(descriptor)
                        if !existingUsers.isEmpty {
                            alertMessage =
                                "User already exists. Please login instead."
                            showAlert = true
                            return
                        }
                    } catch {
                        alertMessage =
                            "Error checking existing users: \(error.localizedDescription)"
                        showAlert = true
                        return
                    }

                    // ✅ All checks passed → Save user
                    let newUser = User(
                        username: username, email: email, password: password)
                    modelContext.insert(newUser)
                    UserDefaults.standard.set(
                        newUser.email, forKey: "loggedInEmail")
                    goToHome = true

                }
                .padding(.top, 36)
                .padding(.horizontal, 20)

                if showAlert {
                    CustomAlertModal(
                        image: Image("info"),
                        title: alertMessage,
                        showCancelButton: false,
                        onNo: {
                            print("no")
                        },
                        onYes: {
                            print("yes")
                        },
                        onOk: {
                            print("OK tapped")
                            dismiss()
                        },
                        onDismiss: {
                            dismiss()
                        }
                    )
                }

                HStack(spacing: 5) {

                    Text("already.have.account")
                        .winkySans(size: 14, weight: 400, color: .black)

                    Button(action: {
                        goToHome = true
                    }) {
                        Text("Login")
                            .winkySans(size: 14, weight: 500, color: .black)
                            .underline()
                    }
                    .padding(.trailing, 20)
                    .navigationDestination(
                        isPresented: $goToHome
                    ) {
                        Home()
                        Text("")
                            .hidden()
                    }

                    //                    NavigationLink(
                    //                        "", destination: Login(), isActive: $goToLogin
                    //                    )
                    //                    .hidden()

                }.padding(.top, 11)

            }.padding(.horizontal, 24)
        }.hideNavBar()

    }
}
