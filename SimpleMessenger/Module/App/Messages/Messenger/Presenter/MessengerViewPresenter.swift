//
//  MessengerViewPresenter.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 06.08.2024.
//

import Foundation
import MessageKit

protocol MessengerPresenterProtocol {
    var title: String { get set }
    var selfSender: Sender { get set }
    var messages: [Message] { get set }

    func sendMessage(message: Message)
}

class MessengerPresenter: MessengerPresenterProtocol {
    weak var view: MessengerViewProtocol?
    var messages: [Message]
    var title: String
    var selfSender: Sender
    private var convoId: String?
    private var otherId: String
    private lazy var otherSender: Sender = Sender(senderId: otherId, displayName: title)
    private let messageSendManager = MessageSendManager()
    private let getMessagesManager = GetMessagesManager()

    init(view: MessengerViewProtocol?, convoId: String?, otherId: String, name: String) {
        self.view = view
        self.convoId = convoId
        self.title = name
        self.otherId = otherId
        self.messages = []

        self.selfSender = Sender(
            senderId: FirebaseManager.shared.getUser()!.uid,
            displayName: UserDefaults.standard.string(forKey: "selfName") ?? ""
        )

        if let convoId {
            getMessages(convoId: convoId)
            loadNewMessage(convoId: convoId)
        }
    }

    func sendMessage(message: Message) {
        switch message.kind {
        case .text(let text):
            messageSendManager.sendMessage(message: text, convoId: convoId, otherUser: otherSender) { [weak self] convoId in
                self?.convoId = convoId
            }
        default:
            break
        }
    }

    func getMessages(convoId: String) {
        getMessagesManager.getMessages(convoId: convoId) { [weak self] messages in
            guard let self else { return }

            self.messages = messages
            self.view?.reloadCollection()
        }
    }

    func loadNewMessage(convoId: String) {
        getMessagesManager.loadNewMessage(convoId: convoId) { [weak self] message in
            guard let self else { return }

            if message.sender.senderId != selfSender.senderId {
                self.messages.append(message)
                view?.reloadCollection()
            }
        }
    }
}

