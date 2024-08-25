//
//  RegViewPresenter.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 01.08.2024.
//

import Foundation

protocol RegViewPresenterProtocol: AnyObject {
//    init(view: RegViewProtocol)
    func sendToRegist(userInfo: UserInfo)
}

class RegViewPresenter: RegViewPresenterProtocol {
    
    weak var view: RegViewProtocol?
    private let registManager = RegistrationManager()
    private let validator = FieldValidator()

    required init(view: any RegViewProtocol) {
        self.view = view
    }

    func sendToRegist(userInfo: UserInfo) {

        if validator.isValid(.email, userInfo.email),
           validator.isValid(.password, userInfo.password) {
            registManager.createUser(userInfo: userInfo) { result in
                switch result {
                case .success(let success):
                    if success {
                        NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.state: WindowManager.app])
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        } else {
            print("Данные не прошли валидацию")
        }
    }
}
