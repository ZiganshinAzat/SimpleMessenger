//
//  TextField.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 26.07.2024.
//

import Foundation
import UIKit

class TextField: UITextField {

    var fieldPlaceHolder: String
    var isPassword: Bool

    init(frame: CGRect = .zero ,fieldPlaceHolder: String, isPassword: Bool = false) {
        self.fieldPlaceHolder = fieldPlaceHolder
        self.isPassword = isPassword
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTextField() {
        placeholder = fieldPlaceHolder
        isSecureTextEntry = isPassword
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        leftViewMode = .always
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        rightViewMode = .always
        backgroundColor = .white
        textColor = .black
        layer.cornerRadius = 10
    }
}
