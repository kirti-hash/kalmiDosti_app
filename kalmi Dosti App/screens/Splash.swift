//
//  Splash.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 20/03/25.
//

import SwiftUI

struct Splash: View {
    @State private var logoScale: CGFloat = 0.6
    @State private var logoOpacity: Double = 0.0
    @State private var textOffset: CGFloat = 20
    @State private var textOpacity: Double = 0.0

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.themeGreen, Color.faceB5]),
                startPoint: UnitPoint(x: 0.2, y: 0.3),
                endPoint: .topTrailing
            )
            .ignoresSafeArea()

            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                    .animation(.easeOut(duration: 1.2), value: logoScale)
                    .animation(.easeOut(duration: 1.2), value: logoOpacity)

                Text("Onboarding.KalmiDosti")
                    .notoSerif(size: 40, weight: 700, color: .black)
                    .offset(y: textOffset)
                    .opacity(textOpacity)
                    .animation(.easeOut(duration: 1.0).delay(0.5), value: textOffset)
                    .animation(.easeOut(duration: 1.0).delay(0.5), value: textOpacity)
            }
        }
        .onAppear {
            logoScale = 1.0
            logoOpacity = 1.0
            textOffset = 0
            textOpacity = 1.0
        }
    }
}

//#Preview {
//    Splash()
//}
