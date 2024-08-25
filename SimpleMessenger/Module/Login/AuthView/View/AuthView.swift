//
//  AuthView.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 26.07.2024.
//

import UIKit
import SnapKit

protocol AuthViewProtocol: AnyObject {

}

class AuthView: UIViewController, AuthViewProtocol {
    
    var presenter: AuthViewPresenterProtocol!

    let pageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = .localize("authTitleLabel")
        label.textColor = .white
        label.font = .systemFont(ofSize: 26, weight: .black)

        return label
    }()

    lazy var emailField: UITextField = TextField(fieldPlaceHolder: "Email")
    lazy var passwordField: UITextField = TextField(
        fieldPlaceHolder: .localize("passwordPlaceholder"),
        isPassword: true
    )

    private lazy var authButton: UIButton = SimpleButton(buttonText: .localize("authButtonText")) { [weak self] in
        guard let self else { return }
        guard let email = emailField.text,
              email.isEmpty == false,
              let password = passwordField.text,
              password.isEmpty == false else { return }
        
        let userInfo = UserInfo(email: email, password: password)
        presenter.sendToAuth(userInfo: userInfo)
    }

    private lazy var bottomButton: UIButton = SimpleButton(buttonText: .localize("regButtonText"), buttonColor: .clear, titleColor: .white) {
        NotificationCenter.default.post(name: .windowManager, object: nil, userInfo: [String.state: WindowManager.reg])
    }

    override func viewDidLoad() {
        super.viewDidLoad() 

        setupView()
        setupConstraints()
    }

    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(pageTitleLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(authButton)
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
            make.centerY.equalToSuperview().offset(-35)
        }

        passwordField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerY.equalToSuperview().offset(35)
        }

        authButton.snp.makeConstraints { make in
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
