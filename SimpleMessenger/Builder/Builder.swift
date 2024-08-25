//
//  Builder.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 26.07.2024.
//

import Foundation
import UIKit

class Builder {
    
    static func getAuthView() -> UIViewController {
        let view = AuthView()
        let presenter = AuthViewPresenter(view: view)

        view.presenter = presenter

        return view
    } 

    static func getRegView() -> UIViewController {
        let view = RegView()
        let presenter = RegViewPresenter(view: view)

        view.presenter = presenter

        return view
    }   

    static func getTabBarView() -> UIViewController {
        let view = TabBarView()
        let presenter = TabBarPresenter(view: view)

        view.presenter = presenter

        return view
    }

    static func getUserListView() -> UIViewController {
        let view = UserListView()
        let presenter = UserListViewPresenter(view: view)

        view.presenter = presenter

        return view
    }

    static func getMessagesListView() -> UIViewController {
        let view = MessagesListView()
        let presenter = MessagesListViewPresenter(view: view)

        view.presenter = presenter

        return view
    }

    static func getMessengerView(chatItem: ChatItem, hidesBottomBarWhenPushed: Bool = false) -> UIViewController {
        let view = MessengerView()
        view.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        let presenter = MessengerPresenter(
            view: view,
            convoId: chatItem.convoId,
            otherId: chatItem.otherUserId,
            name: chatItem.name
        )
        view.presenter = presenter

        return view
    }
}
