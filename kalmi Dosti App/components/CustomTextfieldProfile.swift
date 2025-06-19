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

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .winkySans(size: 20, weight: 600, color: .black)
               
            TextField(placeholder, text: $text)
                .padding(12)
                .background(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: borderWidth)
                )
                .cornerRadius(cornerRadius)
               
        } .padding(.horizontal, 22)
    }
}
