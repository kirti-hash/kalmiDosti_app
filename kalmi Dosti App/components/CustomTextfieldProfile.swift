//
//  CustomTextfieldProfile.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 19/06/25.
//

import SwiftUI

struct CustomTextfieldProfile: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    var backgroundColor: Color = Color(.systemGray6)
    var borderColor: Color = .gray
    var cornerRadius: CGFloat = 8
    var borderWidth: CGFloat = 1
    var isPassword: Bool = false

    @State private var isSecure: Bool = true

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .winkySans(size: 20, weight: 600, color: .black)

            ZStack(alignment: .trailing) {
                HStack {
                    Group {
                        if isPassword && isSecure {
                            SecureField(placeholder, text: $text)
                        } else {
                            TextField(placeholder, text: $text)
                        }
                    }
                    .font(.custom("WinkySans", size: 15))
                    .foregroundColor(.black)
                    .padding(12)

                    if isPassword {
                        Button(action: {
                            isSecure.toggle()
                        }) {
                            Image(
                                systemName: isSecure
                                    ? "eye.slash.fill" : "eye.fill"
                            )
                            .foregroundColor(.gray)
                        }
                        .padding(.trailing, 12)
                    }
                }
                .background(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: borderWidth)
                )
                .cornerRadius(cornerRadius)
            }
        }
        .padding(.horizontal, 22)
    }
}
