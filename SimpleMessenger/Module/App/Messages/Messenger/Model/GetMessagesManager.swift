//
//  GetMessagesManager.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 15.08.2024.
//

import Foundation
import Firebase

class GetMessagesManager {

    var lastSnapshot: DocumentSnapshot?

    func getMessages(convoId: String, completion: @escaping ([Message]) -> Void) {
        Firestore.firestore()
            .collection(.conversations)
            .document(convoId)
            .collection(.messages)
            .limit(to: 50)
            .order(by: "date")
            .getDocuments { snap, err in
                guard err == nil else { print(err!.localizedDescription); return }
                guard let docs = snap?.documents else { return }

                self.lastSnapshot = docs.last

                let messages = docs.compactMap { doc in
                    Message(messageId: doc.documentID, data: doc.data())
                }
                completion(messages)
            }
    }

    func loadNewMessage(convoId: String, completion: @escaping (Message) -> Void) {
        Firestore.firestore()
            .collection(.conversations)
            .document(convoId)
            .collection(.messages)
            .order(by: "date", descending: true)
            .limit(to: 1)
            .addSnapshotListener { snap, err in
                guard err == nil else { print(err!.localizedDescription); return }

                if let hasPending = snap?.metadata.hasPendingWrites, !hasPending {
                    guard let docs = snap?.documents, let message = docs.first else { return }
                    let newMessage = Message(messageId: message.documentID, data: message.data())
                    completion(newMessage)
                }
            }
    }
}
