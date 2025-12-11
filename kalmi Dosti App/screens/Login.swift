//
//  Login.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 05/06/25.
//

import SwiftData
import SwiftUI

struct Login: View {
    @Environment(\.modelContext) var modelContext
    @State var email = ""
    @State var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @AppStorage("isLoggedIn") var isLoggedIn = false

    // var onLoginSuccess: () -> Void
    @State private var goToRegister = false
    @State private var goToHome = false

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
                Text("login.to.your")
                    .winkySans(size: 15, weight: 400, color: .black)
                    .padding(.top, 13)

                VStack(spacing: 12) {
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

                }.padding(.top, 44)
                CustomButton(title: "Login", backgroundColor: .faceB5) {
                    print("Login tapped")
                    
                    let emailTrimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
                    let passTrimmed = password.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    // Fetch users with matching credentials
                    let descriptor = FetchDescriptor<User>(
                        predicate: #Predicate { $0.email == emailTrimmed && $0.password == passTrimmed }
                    )

                    do {
                        let existingUsers = try modelContext.fetch(descriptor)

                        if existingUsers.first != nil {
                            // User exists → go to Home
                            goToHome = true
                            isLoggedIn = true
                            UserDefaults.standard.set(
                                existingUsers.first?.email,
                                forKey: "loggedInEmail")
                        } else {
                            // No matching user → Show alert
                            alertMessage =
                                "User does not exist please register to continue"
                            showAlert = true
                        }
                        
                        
                        
                    } catch {
                        alertMessage =
                            "Error checking login: \(error.localizedDescription)"
                        showAlert = true
                    }
                    
                    

                }
                .padding(.top, 36)
                .padding(.horizontal, 20)

                

                HStack(spacing: 5) {

                    Text("Don't.have.any")
                        .winkySans(size: 14, weight: 400, color: .black)

                    Button(action: {
                        goToRegister = true

                    }) {
                        Text("Register")
                            .winkySans(size: 14, weight: 500, color: .black)
                            .underline()
                    }
                    .padding(.trailing, 20)
//                    .navigationDestination(
//                        isPresented: $goToRegister
//                    ) {
//                        Register()
//                        Text("")
//                            .hidden()
//                    }
                    NavigationLink(
                        "", destination: Home(), isActive: $goToHome
                     )
                     .hidden()
                    
                    NavigationLink(
                        "", destination: Register(), isActive: $goToRegister)
                   .hidden()

                }.padding(.top, 11)

                Spacer()

                Text("A.virtual.friend")
                    .winkySans(size: 13, weight: 400, color: .black)
                    .multilineTextAlignment(.center)

                
                
            }.padding(.horizontal, 24)
                .overlay {
                    if showAlert {
                        CustomOkAlert(
                            title: alertMessage,
                            onOk: {
                                showAlert = false
                            },
                            onDismiss: {
                                showAlert = false
                            }
                        )
                    }
                }

            
//            if showAlert {
//                CustomAlertModal(
//                    image: Image("info"),
//                    title: alertMessage,
//                    showCancelButton: false,
//                    onNo: {
//                        print("no")
//
//                    },
//                    onYes: {
//                        print("yes")
//
//                    },
//                    onOk: {
//                        print("OK tapped")
//                        dismiss()
//                    },
//                    onDismiss: {
//                        dismiss()
//                    }
//                )
//            }
            
        }.hideNavBar()

    }
}
