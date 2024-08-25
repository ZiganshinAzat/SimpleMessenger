//
//  FirebaseManager.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 26.07.2024.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseManager {

    static let shared = FirebaseManager()
    let auth = Auth.auth()

    private init() { }

    func checkLoginStatus(completion: @escaping (Bool) -> Void) {
        _ = auth.addStateDidChangeListener { auth, user in
            if user != nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    func getUser() -> User? {
        if let user = auth.currentUser {
            return user
        } else {
            return nil
        }
    }

    func signOut() {
        do {
            try auth.signOut()
            NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.state: WindowManager.auth])
        } catch {
            print(error.localizedDescription)
        }
    }
}
