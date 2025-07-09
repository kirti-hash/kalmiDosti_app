//
//  CustomModalView.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 17/06/25.
//

import SwiftUI

struct CustomModalView: View {
    var image: Image
    var title: String
    var onDiscard: () -> Void
    var onSave: () -> Void
    var onDismiss: () -> Void

    var body: some View {
        ZStack {
            // Translucent background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }

            // Modal Card
            VStack(spacing: 18) {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)

                Text(title)
                    .winkySans(size: 23, weight: 500, color: .black)
                    .multilineTextAlignment(.center)

                HStack(spacing: 24) {
                    Button("Discard") {
                        onDiscard()
                    }
                    .font(.custom("winkySans", size: 18).weight(.regular))
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.white)
                    .cornerRadius(18)

                    Button("Save") {
                        onSave()
                    }
                    .font(.custom("winkySans", size: 18).weight(.regular))
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.faceB5)
                    .cornerRadius(18)
                }
            }
            .padding()
            .background(Color.themeGreenDark)
            .cornerRadius(16)
            .padding(.horizontal, 40)

        }
    }
}
