//
//  customPageControl.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 05/06/25.
//

import SwiftUI

struct CustomPageControl: View {
    var total: Int
    var selectedIndex: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<total, id: \.self) { index in
                if index == selectedIndex {
                    Capsule()
                        .fill(Color.themeGreenDark)
                        .frame(width: 23, height: 13)
                } else {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 13, height: 13)
                }
            }
        }
    }
}
