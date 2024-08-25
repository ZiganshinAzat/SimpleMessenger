//
//  TabBarPresenter.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 02.08.2024.
//

import Foundation
import UIKit

protocol TabBarPresenterProtocol: AnyObject {
    init(view: TabBarViewProtocol)
}

class TabBarPresenter: TabBarPresenterProtocol {
    
    weak var view: TabBarViewProtocol?

    required init(view: any TabBarViewProtocol) {
        self.view = view 

        setupViewControllers()
    }

    private func setupViewControllers() {
        let userList = Builder.getUserListView()
        userList.title = .localize("tabUsers")
        userList.tabBarItem.image = UIImage(systemName: "person.3")

        let messagesList = Builder.getMessagesListView()
        messagesList.title = .localize("tabMessages")
        messagesList.tabBarItem.image = UIImage(systemName: "message")

        view?.setViewControllers(viewControllers: [
            UINavigationController(rootViewController: userList),
            UINavigationController(rootViewController: messagesList)
        ])
    }
}
