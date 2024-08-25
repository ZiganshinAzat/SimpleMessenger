//
//  AuthManager.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 12.08.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthManager {

    func auth(userInfo: UserInfo, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: userInfo.email, password: userInfo.password) { result, error in

            guard error == nil else {
                completion(.failure(error!))
                return
            }

            guard let result else { return }

            Firestore.firestore()
                .collection(.users)
                .document(result.user.uid)
                .getDocument { snap, err in
                    guard err == nil else { return }
                    if let userData = snap?.data() {
                        let name = userData["name"] as? String ?? ""
                        UserDefaults.standard.setValue(name, forKey: "selfName")
                    }
                }

            if result.user.isEmailVerified {
                completion(.success(true))
            } else {
                completion(.success(false))
            }
        }
    }
}
