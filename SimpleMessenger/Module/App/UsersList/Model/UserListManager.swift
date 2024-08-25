//
//  UserListManager.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 12.08.2024.
//

import Foundation
import Firebase

class UserListManager {

    private let firestore = Firestore.firestore()
    private var lastDoc: DocumentSnapshot?

    func getAllUsers(completion: @escaping ([ChatUser]) -> Void) {
        var query: Query?

        if lastDoc == nil {
            query = firestore
                .collection(.users)
                .limit(to: 10)
        } else {
            query = firestore
                .collection(.users)
                .limit(to: 10)
                .start(afterDocument: lastDoc!)
        }

        query!
            .getDocuments { [weak self] snap, err in
                guard err == nil else { return }
                guard let docs = snap?.documents else { return }
                guard let self else { return }
                guard let selfId = FirebaseManager.shared.getUser()?.uid else { return }

                lastDoc = docs.last

                var users: [ChatUser] = []
                let dispatchGroup = DispatchGroup()

                docs.forEach { [weak self] user in
                    if selfId != user.documentID {
                        dispatchGroup.enter()
                        self?.checkConvo(selfId: selfId, otherId: user.documentID) { convoId in
                            if convoId == nil {
                                let userData = user.data()
                                let user = ChatUser(uid: user.documentID, userInfo: userData)
                                users.append(user)
                            }
                            dispatchGroup.leave()
                        }
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    completion(users)
                }
            }
    }

    private func checkConvo(selfId: String, otherId: String, completion: @escaping (String?) -> Void) {
        firestore
            .collection(.users)
            .document(selfId)
            .collection(.conversations)
            .whereField("otherId", isEqualTo: otherId)
            .getDocuments { snap, err in
                guard err == nil else {
                    print(err!.localizedDescription)
                    completion(nil)
                    return
                }

                if let documents = snap?.documents, !documents.isEmpty {
                    let convoId = documents.first!.documentID
                    completion(convoId)
                } else {
                    completion(nil)
                }
            }
    }
}
