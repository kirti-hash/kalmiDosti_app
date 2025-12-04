//
//  CustomOkAlert.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 04/12/25.
//

import SwiftUI

struct CustomOkAlert: View {
    var title: String
    var onOk: () -> Void
    var onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            // Dim background – tap to dismiss
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }
            
            VStack(spacing: 20) {
                
                Image("info")
                    .resizable()
                    .frame(width: 60, height: 60)
                
                Text(title)
                    .winkySans(size: 23, weight: 500, color: .black)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                Button(action: {
                    onOk()
                }) {
                    Text("OK")
                        .font(.custom("winkySans", size: 18).weight(.regular))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.faceB5)
                        .cornerRadius(18)
                }
            }
            .padding()
            .frame(width: 280)
            .background(Color.themeGreenDark)
            .cornerRadius(16)
            .shadow(radius: 10)
        }
        .animation(.easeInOut, value: title)
    }
}
