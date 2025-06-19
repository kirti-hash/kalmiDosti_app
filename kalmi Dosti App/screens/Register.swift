//
//  Register.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 05/06/25.
//

import SwiftUI

struct Register: View {

    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State private var confirmPassword = ""
    @State private var goToLogin = false
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
                    print("Login tapped")
                    goToHome = true
                }
                .padding(.top, 36)
                .padding(.horizontal, 20)

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

                    
                    NavigationLink(
                        "", destination: Home(), isActive: $goToHome
                    )
                    .hidden()
                    
                    NavigationLink(
                        "", destination: Login(), isActive: $goToLogin
                    )
                    .hidden()
                    
                }.padding(.top, 11)

            }.padding(.horizontal, 24)
        }.hideNavBar()

    }
}

//#Preview {
//    Register()
//}
