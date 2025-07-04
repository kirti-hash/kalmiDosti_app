//
//  ContentView.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 17/03/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isLoggedIn = false
       @State private var showSplash = true

    var body: some View {
        NavigationStack {
                    if showSplash {
                        Splash()
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    // Check login state or move to auth
                                    showSplash = false
                                    isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
                                }
                            }
                    } else {
                        if isLoggedIn {
                            Home(
//                                onLogout: {
//                                isLoggedIn = false
//                                UserDefaults.standard.set(false, forKey: "isLoggedIn")
//                            }
                            )
                        } else {
                            Welcome(onLoginSuccess: {
                                isLoggedIn = true
                                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                            })
                        }
                    }
        }.toolbar(.hidden, for: .automatic )
    }
}



