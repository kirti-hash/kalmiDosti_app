//
//  Diary.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 07/06/25.
//

import SwiftUI

struct Diary: View {
    
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.themeGreen, Color.faceB5]),
                startPoint: UnitPoint(x: 0.8, y: 0.5),
                endPoint: .topTrailing
            )
            .ignoresSafeArea()
        }
    }
}

#Preview {
    Diary()
}
