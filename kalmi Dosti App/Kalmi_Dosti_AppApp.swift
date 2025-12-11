//
//  kalmi_Dosti_AppApp.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 17/03/25.
//

import SwiftData
import SwiftUI

@main
struct Kalmi_Dosti_AppApp: App {
    
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
  
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .ignoresSafeArea()
        }
        .modelContainer(for: User.self)
    }
}
