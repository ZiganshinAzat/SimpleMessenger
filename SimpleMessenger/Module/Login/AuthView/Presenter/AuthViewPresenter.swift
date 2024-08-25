//
//  AuthViewPresenter.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 26.07.2024.
//

import UIKit

protocol AuthViewPresenterProtocol: AnyObject {
    init(view: AuthViewProtocol)
    func sendToAuth(userInfo: UserInfo)
}

class AuthViewPresenter: AuthViewPresenterProtocol {

    weak var view: AuthViewProtocol?
    private let authManager = AuthManager()

    required init(view: any AuthViewProtocol) {
        self.view = view
    }

    func sendToAuth(userInfo: UserInfo) {
        authManager.auth(userInfo: userInfo) { result in
            switch result {
            case .success(let success):
                if success {
                    print("У пользователя подтверждена почта")
                } else {
                    print("У пользователя не подтверждена почта")
                }
                NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.state: WindowManager.app])
            case .failure(let failure):
                print(failure.localizedDescription)
                print("Неверные данные")
            }
        }
    }
}
