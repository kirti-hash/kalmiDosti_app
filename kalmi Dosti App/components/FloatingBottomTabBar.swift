//
//  FloatingBottomTabBar.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 06/06/25.
//

import SwiftUI

struct FloatingBottomTabBar: View {
    @Binding var selectedTab: Tab

    enum Tab: String {
        case home = "Home"
        case profile = "Profile"

        var icon: String {
            switch self {
            case .home: return "house.fill"
            case .profile: return "person.fill"
            }
        }
    }

    var body: some View {
        HStack(spacing: 16) {
            ForEach([Tab.home, Tab.profile], id: \.self) { tab in
                Button(action: {
                    selectedTab = tab
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: tab.icon)
                            .foregroundColor(
                                selectedTab == tab ? .black : .gray)

                        if selectedTab == tab {
                            Text(tab.rawValue)
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .semibold))
                        }
                    }
                    .padding(.horizontal, selectedTab == tab ? 16 : 12)
                    .padding(.vertical, 10)
                    .background(
                        Capsule()
                            .fill(
                                selectedTab == tab
                                    ? Color.themeGreen : Color.white)
                    )
                    .shadow(
                        color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(
            Capsule()
                .fill(Color.white)
        ).shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
        .frame(maxWidth: .infinity)
        .padding(.bottom, 20)  // to float above bottom edge
    }
}
