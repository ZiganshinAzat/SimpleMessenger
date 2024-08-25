//
//  MessagesListManager.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 15.08.2024.
//

import Foundation
import Firebase

class MessagesListManager {

    func getChatsList(completion: @escaping ([ChatItem]) -> Void) {
        guard let selfId = FirebaseManager.shared.getUser()?.uid else { return }

        Firestore.firestore()
            .collection(.users)
            .document(selfId)
            .collection(.conversations)
//            .order(by: "date")
            .addSnapshotListener { snap, err in
                guard err == nil else { print(err!.localizedDescription); return }
                guard let docs = snap?.documents else { return }

                var chatItems: [ChatItem] = []
                docs.forEach { doc in
                    let chatItem = ChatItem(convoId: doc.documentID, data: doc.data())
                    chatItems.append(chatItem)
                }

                completion(chatItems)
            }
    }
}
