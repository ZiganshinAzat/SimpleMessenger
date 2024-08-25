//
//  RegView.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 01.08.2024.
//

import UIKit
import SnapKit

protocol RegViewProtocol: AnyObject {

}

class RegView: UIViewController, RegViewProtocol {

    var presenter: RegViewPresenterProtocol!

    let pageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = .localize("regTitleLabel")
        label.textColor = .white
        label.font = .systemFont(ofSize: 26, weight: .black)

        return label
    }()

    private lazy var nameField: UITextField = TextField(fieldPlaceHolder: .localize("namePlaceholder"))
    private lazy var emailField: UITextField = TextField(fieldPlaceHolder: "Email")
    private lazy var passwordField: UITextField = TextField(
        fieldPlaceHolder: .localize("passwordPlaceholder"),
        isPassword: true
    )

    private lazy var regButton: UIButton = SimpleButton(buttonText: .localize("regButtonText")) { [weak self] in
        guard let self else { return }

        let userInfo = UserInfo(email: emailField.text ?? "", password: passwordField.text ?? "", name: nameField.text)
        presenter.sendToRegist(userInfo: userInfo)
    }

    private lazy var bottomButton: UIButton = SimpleButton(buttonText: .localize("authButtonText"), buttonColor: .clear, titleColor: .white) {
        NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.state: WindowManager.auth])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
    }

    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(pageTitleLabel)
        view.addSubview(nameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(regButton)
        view.addSubview(bottomButton)
    }

    private func setupConstraints() {
        pageTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview().inset(30)
        }

        emailField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
        }

        nameField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
            make.bottom.equalTo(emailField.snp.top).offset(-15)
        }

        passwordField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(emailField.snp.bottom).offset(15)
        }

        regButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }

        bottomButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
    }
}
