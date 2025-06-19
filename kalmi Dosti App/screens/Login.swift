//
//  Login.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 05/06/25.
//

import SwiftUI

struct Login: View {

    @State private var username = ""
    @State private var password = ""
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
                        imageName: "username",
                        placeholder: "Username",
                        text: $username,
                        keyboardType: .default,
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
                    goToHome = true
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

                    NavigationLink(
                        "", destination: Register(), isActive: $goToRegister
                    )
                    
                    NavigationLink(
                        "", destination: Home(), isActive: $goToHome
                    )
                    .hidden()

                }.padding(.top, 11)

                Spacer()

                Text("A.virtual.friend")
                    .winkySans(size: 13, weight: 400, color: .black)
                    .multilineTextAlignment(.center)

            }.padding(.horizontal, 24)
        }.hideNavBar()

    }
}

//#Preview {
//    Login()
//}
