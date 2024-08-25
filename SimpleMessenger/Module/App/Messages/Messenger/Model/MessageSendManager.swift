//
//  MessageSendManager.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 14.08.2024.
//

import Foundation
import Firebase

class MessageSendManager {

    let firestore = Firestore.firestore()

    func sendMessage(
        message: String,
        convoId: String?,
        otherUser: Sender,
        completion: @escaping (String) -> Void
    ) {
        guard let selfId = FirebaseManager.shared.getUser()?.uid else { return }

        if convoId == nil {
            createNewConvo(selfId: selfId, otherUser: otherUser) { [weak self] createdConvoId in
                self?.setMessage(
                    convoId: createdConvoId,
                    message: message,
                    selfId: selfId,
                    otherUser: otherUser
                )
                completion(createdConvoId)
            }
        } else {
            setMessage(
                convoId: convoId!,
                message: message,
                selfId: selfId,
                otherUser: otherUser
            )
        }
    }

    private func createNewConvo(
        selfId: String,
        otherUser: Sender,
        completion: @escaping (String) -> Void
    ) {
        let convoId = UUID().uuidString
        let convoData: [String: Any] = [
            "date": Date(),
            "senderId": selfId,
            "otherId": otherUser.senderId
        ]

        firestore
            .collection(.conversations)
            .document(convoId)
            .setData(convoData, merge: true) { error in
                if error == nil {
                    completion(convoId)
                } else {
                    print(error!.localizedDescription)
                }
            }
    }

    private func setMessage(
        convoId: String,
        message: String,
        selfId: String,
        otherUser: Sender
    ) {
        let messageData: [String: Any] = [
            "date": Date(),
            "senderId": selfId,
            "otherId": otherUser.senderId,
            "message": message
        ]

        firestore
            .collection(.conversations)
            .document(convoId)
            .collection(.messages)
            .document(UUID().uuidString)
            .setData(messageData)

        setLastMessages(
            message: message,
            selfId: selfId,
            otherUser: otherUser,
            convoId: convoId
        )
    }

    private func setLastMessages(
        message: String,
        selfId: String,
        otherUser: Sender,
        convoId: String
    ) {
        // Set self last message
        let selfLastMessage: [String: Any] = [
            "name": otherUser.displayName,
            "otherId": otherUser.senderId,
            "date": Date(),
            "message": message
        ]
        firestore
            .collection(.users)
            .document(selfId)
            .collection(.conversations)
            .document(convoId)
            .setData(selfLastMessage)

        // Set other last message
        let otherLastMessage: [String: Any] = [
            "name": UserDefaults.standard.string(forKey: "selfName") ?? "",
            "otherId": selfId,
            "date": Date(),
            "message": message
        ]
        firestore
            .collection(.users)
            .document(otherUser.senderId)
            .collection(.conversations)
            .document(convoId)
            .setData(otherLastMessage)
    }
}
