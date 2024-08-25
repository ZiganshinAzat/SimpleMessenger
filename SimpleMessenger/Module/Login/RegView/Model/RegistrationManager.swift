//
//  RegistrationManager.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 08.08.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegistrationManager {

    func createUser(
        userInfo: UserInfo,
        completion: @escaping ((Result<Bool, Error>) -> Void)
    ) {
        Auth.auth().createUser(withEmail: userInfo.email, password: userInfo.password) { [weak self] result, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            guard let result else { return }
            guard let self else { return }

            result.user.sendEmailVerification()

            setUserInfo(uid: result.user.uid, userInfo: userInfo) {
                completion(.success(true))
            }
        }
    }

    private func setUserInfo(
        uid: String, userInfo: UserInfo,
        completion: @escaping () -> Void
    ) {
        let userData: [String: Any] = [
            "name": userInfo.name ?? "",
            "email": userInfo.email,
            "regDate": Date()
        ]

        Firestore.firestore()
            .collection(.users)
            .document(uid)
            .setData(userData) { _ in
                UserDefaults.standard.setValue(userData["name"], forKey: "selfName")
                completion()
            }
    }
}
