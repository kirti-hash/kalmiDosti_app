//
//  ReadyToChat.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 05/06/25.
//

import SwiftUI

struct ReadyToChat: View {

    @State private var currentIndex = 2
    @State private var goToNext = false
    @State private var goToLogin = false

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.themeGreen, Color.faceB5]),
                startPoint: UnitPoint(x: 0.2, y: 0.3),
                endPoint: .topTrailing
            )
            .ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                Image("logo")
                    .resizable()
                    .frame(width: 220, height: 220)
                Text("Onboarding.KalmiDosti")
                    .notoSerif(size: 40, weight: 500, color: .black)
                Spacer()

                Text("luca.will.be.ready")
                    .lexend(size: 29, weight: 400, color: .black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)

                CustomPageControl(total: 3, selectedIndex: currentIndex)
                    .padding(.top, 32)
                CustomButton(title: "Next", backgroundColor: .faceB5) {
                    goToNext = true
                    print("Login tapped")
                }.padding(.top, 20)
                
                NavigationLink(
                    "", destination: Login(), isActive: $goToNext
                )
                .hidden()
                
                HStack(spacing: 0) {
                    Spacer()
                    Button(action: {
                        goToNext = true
                    }) {
                        Text("<Skip>")
                            .winkySans(size: 13, weight: 500, color: .black)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                    .padding(.top, 8)
                   
                }

            }.padding(.horizontal, 44)
        }.hideNavBar()

    }
}

//#Preview {
//    ReadyToChat()
//}
