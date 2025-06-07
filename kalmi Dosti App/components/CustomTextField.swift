//
//  CustomTextfield.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 05/06/25.
//

import SwiftUI

struct CustomTextField: View {
    var imageName: String
    var placeholder: LocalizedStringKey
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var backgroundColor: Color = .white
    var shadowColor: Color = .gray.opacity(0.3)
    var isPassword: Bool = false

    @State private var isSecure: Bool = true

    var body: some View {
        HStack {
            Image(imageName)
                .foregroundColor(.gray)
                .frame(width: 24, height: 24)

            if isPassword {
                Group {
                    if isSecure {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
                .font(.custom("WinkySans", size: 15))
                .foregroundColor(.black)
                .keyboardType(keyboardType)

                Button(action: {
                    isSecure.toggle()
                }) {
                    Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                }
            } else {
                TextField(placeholder, text: $text)
                    .font(.custom("WinkySans", size: 15))
                    .foregroundColor(.black)
                    .keyboardType(keyboardType)
            }
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
        .shadow(color: shadowColor, radius: 4, x: 0, y: 0)
    }
}
