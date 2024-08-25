//
//  UserListView.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 05.08.2024.
//

import UIKit

protocol UserListViewProtocol: AnyObject {
    func reloadTable()
}

class UserListView: UIViewController, UserListViewProtocol {

    var presenter: UserListViewPresenterProtocol!

    lazy var signOutButton: UIBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
        style: .done,
        target: self,
        action: #selector(signOut)
    )

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
    }

    private func setupView() {
        self.title = .localize("tabUsers")
        navigationItem.rightBarButtonItem = signOutButton

        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func reloadTable() {
        tableView.reloadData()
    }

    @objc func signOut(){
        FirebaseManager.shared.signOut()
    }
}

extension UserListView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let chatUser = presenter.users[indexPath.row]

        var config = cell.defaultContentConfiguration()
        config.text = chatUser.name
        config.image = UIImage(systemName: "person.circle.fill")

        cell.contentConfiguration = config
        cell.selectionStyle = .none

        return cell
    }
}

extension UserListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = presenter.users[indexPath.row]

        let chatItem = ChatItem(convoId: nil, name: user.name, otherUserId: user.id, date: Date(), lastMessage: nil)

        let messanger = Builder.getMessengerView(chatItem: chatItem, hidesBottomBarWhenPushed: true)

        navigationController?.pushViewController(messanger, animated: true)
    }
}
