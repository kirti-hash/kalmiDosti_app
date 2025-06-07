//
//  Fonts+Custom.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 25/03/25.
//

import SwiftUI

extension Text {
    func lexend(size: CGFloat, weight: CGFloat, color: Color) -> some View {
        self.font(
            Font.custom("Lexend", size: size)
                .weight(FontWeightHelper.from(weight))
        )
        .foregroundColor(color)
    }

    func notoSerif(size: CGFloat, weight: CGFloat, color: Color) -> some View {
        self.font(
            Font.custom("Noto Serif", size: size)
                .weight(FontWeightHelper.from(weight))
        )
        .foregroundColor(color)
    }

    func notoSerifItalic(size: CGFloat, weight: CGFloat, color: Color)
        -> some View
    {
        self.font(
            Font.custom("NotoSerif-Italic", size: size)
                .weight(FontWeightHelper.from(weight))
        )
        .foregroundColor(color)
    }

    func winkySans(size: CGFloat, weight: CGFloat, color: Color) -> some View {
        self.font(
            Font.custom("Winky Sans", size: size)
                .weight(FontWeightHelper.from(weight))
        )
        .foregroundColor(color)
    }

    func winkySansItalic(size: CGFloat, weight: CGFloat, color: Color)
        -> some View
    {
        self.font(
            Font.custom("WinkySans-Italic", size: size)
                .weight(FontWeightHelper.from(weight))
        )
        .foregroundColor(color)
    }
}

// Helper to map numeric weight values to SwiftUI Font.Weight
struct FontWeightHelper {
    static func from(_ weight: CGFloat) -> Font.Weight {
        switch weight {
        case ..<200: return .ultraLight
        case 200..<300: return .thin
        case 300..<400: return .light
        case 400..<500: return .regular
        case 500..<600: return .medium
        case 600..<700: return .semibold
        case 700..<800: return .bold
        case 800..<900: return .heavy
        default: return .black
        }
    }
}
