//
//  Message.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 06.08.2024.
//

import Foundation
import MessageKit
import Firebase

struct Message: MessageType {
    var sender: any MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind

    init(sender: any MessageKit.SenderType, messageId: String, sentDate: Date, kind: MessageKit.MessageKind) {
        self.sender = sender
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = kind
    }

    init(messageId: String, data: [String: Any]) {
        self.messageId = messageId
        self.sender = Sender(
            senderId: data["senderId"] as? String ?? "",
            displayName: ""
        )
        self.kind = .text(data["message"] as? String ?? "")
        self.sentDate = {
            let timestamp = data["date"] as? Timestamp
            return timestamp?.dateValue() ?? Date()
        }()
    }

//    static func getMock() -> [Message] {
//        [
//            Message(sender: Sender(senderId: "1", displayName: "Azat"), messageId: UUID().uuidString, sentDate: Date().addingTimeInterval(-1), kind: .text("Text text text text")),
//            Message(sender: Sender(senderId: "2", displayName: "User"), messageId: UUID().uuidString, sentDate: Date().addingTimeInterval(-3600), kind: .text("Text text text text")),
//            Message(sender: Sender(senderId: "1", displayName: "Azat"), messageId: UUID().uuidString, sentDate: Date().addingTimeInterval(-7200), kind: .text("Text text text text"))
//        ]
//    }
}
