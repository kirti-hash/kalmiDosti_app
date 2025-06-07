//
//  Onboarding.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 25/03/25.
//

import SwiftUI

struct Onboarding: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.themeGreen, Color.faceB5]),
                startPoint: UnitPoint(x: 0.2, y: 0.3),
                endPoint: .topTrailing
            )
            .ignoresSafeArea()
            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .frame(width: 222, height: 222)
                Text("Onboarding.KalmiDosti")
                    .notoSerif(size: 58, weight: 800, color: .black)
                Spacer()
                CustomButton(title: "Get.Started", backgroundColor: .faceB5) {
                    print("Login tapped")
                }
                .padding(.horizontal, 24)
                Text("A.virtual.friend")
                    .winkySans(size: 14, weight: 500, color: .black)
                    .multilineTextAlignment(.center)

            }.padding(.horizontal, 20)
        }

    }
}
#Preview {
    Onboarding()
}
