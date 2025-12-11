//
//  ContentView.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 17/03/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @State private var showSplash: Bool = true
    @Query var items: [User]

    var body: some View {
        NavigationStack {
            

            if showSplash {
                        Splash()
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    withAnimation {
                                        showSplash = false
                                    }
                                }
                            }
                    }
                    else if !hasSeenOnboarding {
                Welcome()
            } else if !isLoggedIn {
                Login()
            }  else {
                Home()
            }
            
            
        }.toolbar(.hidden, for: .automatic)
    }
}
