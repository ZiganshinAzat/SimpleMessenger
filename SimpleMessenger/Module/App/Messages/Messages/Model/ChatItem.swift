//
//  ChatItem.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 06.08.2024.
//

import Foundation
import Firebase

struct ChatItem {
    var convoId: String?
    var name: String
    var otherUserId: String
    var date: Date
    var lastMessage: String?

    init(convoId: String? = nil, name: String, otherUserId: String, date: Date, lastMessage: String? = nil) {
        self.convoId = convoId
        self.name = name
        self.otherUserId = otherUserId
        self.date = date
        self.lastMessage = lastMessage
    }

    init(convoId: String, data: [String: Any]) {
        self.convoId = convoId
        self.name = data["name"] as? String ?? ""
        self.otherUserId = data["otherId"] as? String ?? ""
        self.lastMessage = data["message"] as? String ?? ""
        self.date = {
            let timestamp = data["date"] as? Timestamp
            return timestamp?.dateValue() ?? Date()
        }()
    }
}


