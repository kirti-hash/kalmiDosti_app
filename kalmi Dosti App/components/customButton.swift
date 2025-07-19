//
//  customButton.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 05/06/25.
//

import SwiftUI

struct CustomButton: View {
    var title: LocalizedStringKey
    var backgroundColor: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .winkySans(size: 24, weight: 500, color: .black)
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .cornerRadius(55)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        }
    }
}
