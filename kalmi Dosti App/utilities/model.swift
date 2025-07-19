//
//  model.swift
//  kalmi Dosti App
//
//  Created by kirti rawat on 25/06/25.
//

import Foundation
import SwiftData

@Model
class User {
    var id: UUID
    var username: String
    var email: String
    var password: String
    var imageData: Data?
    var diary: [Journal] = []  // ✅ Each user has multiple journals
    var chats: [ChatMessageModel] = []

    init(
        username: String, email: String, password: String,
        imageData: Data? = nil, diary: [Journal] = [],
        chats: [ChatMessageModel] = []
    ) {
        self.id = UUID()
        self.username = username
        self.email = email
        self.password = password
        self.imageData = imageData
        self.diary = diary
        self.chats = chats
    }
}

@Model
class Journal {
    var id: UUID
    var title: String
    var summary: String

    init(title: String, summary: String) {
        self.id = UUID()
        self.title = title
        self.summary = summary
    }
}

@Model
class ChatMessageModel {
    var id: UUID
    var text: String
    var isCurrentUser: Bool
    var date: Date

    init(text: String, isCurrentUser: Bool, date: Date) {
        self.id = UUID()
        self.text = text
        self.isCurrentUser = isCurrentUser
        self.date = date
    }
}
