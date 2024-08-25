//
//  MessagesListViewPresenter.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 05.08.2024.
//

import Foundation

protocol MessagesListViewPresenterProtocol: AnyObject {
    var chatList: [ChatItem] { get set }
}

class MessagesListViewPresenter: MessagesListViewPresenterProtocol {

    var chatList: [ChatItem] = []

    weak var view: MessagesListViewProtocol?
    private let messagesListManager = MessagesListManager()

    init(view: MessagesListViewProtocol?) {
        self.view = view
        getChatList()
    }

    func getChatList() {
        messagesListManager.getChatsList { [weak self] chatItems in
            guard let self else { return }
            chatList = chatItems
            view?.reloadTable()
        }
    }
}
