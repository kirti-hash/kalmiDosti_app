//
//  model.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 25/06/25.
//

import SwiftData
import Foundation

@Model
class User {
    var id: UUID
    var username: String
    var password: String

    init(username: String, password: String) {
        self.id = UUID()
        self.username = username
        self.password = password
    }
}

