//
//  MessagesView.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 05.08.2024.
//

import UIKit

protocol MessagesListViewProtocol: AnyObject {
    func reloadTable()
}

class MessagesListView: UIViewController, MessagesListViewProtocol {

    var presenter: MessagesListViewPresenterProtocol!

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

//    override func viewWillAppear(_ animated: Bool) {
//        hidesBottomBarWhenPushed = true
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
    }

//    override func viewDidDisappear(_ animated: Bool) {
//        hidesBottomBarWhenPushed = false
//    }

    func reloadTable() {
        tableView.reloadData()
    }

    private func setupView() {
        self.title = .localize("tabMessages")

        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MessagesListView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.chatList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let chatItem = presenter.chatList[indexPath.row]

        var config = cell.defaultContentConfiguration()
        config.text = chatItem .name
        config.image = UIImage(systemName: "person.fill")
        config.secondaryText = chatItem.lastMessage?.truncate(to: 80)

        cell.contentConfiguration = config
        cell.selectionStyle = .none

        return cell
    }
}

extension MessagesListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatItem = presenter.chatList[indexPath.row]

        let messengerController = Builder.getMessengerView(chatItem: chatItem, hidesBottomBarWhenPushed: true)

        navigationController?.pushViewController(messengerController, animated: true )
    }
}
