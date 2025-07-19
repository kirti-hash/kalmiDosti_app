//
//  Splash.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 20/03/25.
//

import SwiftUI

struct Splash: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.themeGreen, Color.faceB5]),
                startPoint: UnitPoint(x: 0.2, y: 0.3),
                endPoint: .topTrailing
            )
            .ignoresSafeArea()
            VStack {
                Text("ContentView.WelcomeMessage".localized(arguments: "Peter"))
            }
        }
    }
}

#Preview {
    Splash()
}
