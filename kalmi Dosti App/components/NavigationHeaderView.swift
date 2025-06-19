//
//  NavigationHeaderView.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 17/06/25.
//

import SwiftUI

struct NavigationHeaderView: View {
    var title: String
    var showTitle: Bool = true
    var showRightImage1: Bool = true
    var showRightImage2: Bool = true
    var rightImage1: Image?
    var rightImage2: Image?
    var bgColor: Color = .themeGreen
    var onBack: () -> Void
    var onRightImage1Tap: () -> Void = {}
    var onRightImage2Tap: () -> Void = {}

    var body: some View {
        HStack {
            // Back button + title
            HStack(spacing: 8) {
                Button(action: onBack) {
                    Image("back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 21)
                }

                if showTitle {
                    Text(title)
                        .lexend(size: 30, weight: 600, color: .black)
                        .lineLimit(1)
                }
            }

            Spacer()

            // Right side buttons
            HStack(spacing: 16) {
                if showRightImage1, let image1 = rightImage1 {
                    Button(action: onRightImage1Tap) {
                        image1
                            .resizable()
                            .scaledToFit()
                            .frame(width: 28, height: 28)
                    }
                }

                if showRightImage2, let image2 = rightImage2 {
                    Button(action: onRightImage2Tap) {
                        image2
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }
            }
        }
        .padding()
        .foregroundColor(.primary)
        .background(bgColor)
    }
}
