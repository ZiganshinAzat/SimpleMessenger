//
//  UserListViewPresenter.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 05.08.2024.
//

import Foundation

protocol UserListViewPresenterProtocol: AnyObject {
    // init(view: UserListViewProtocol)
    var users: [ChatUser] { get set }
}

class UserListViewPresenter: UserListViewPresenterProtocol {

    weak var view: UserListViewProtocol?
    private let userListManager = UserListManager()
    var users: [ChatUser] = []

    required init(view: any UserListViewProtocol) {
        self.view = view

        userListManager.getAllUsers { [weak self] users in
            guard let self else { return }
            self.users = users
            self.view?.reloadTable()
        }
    }
}
