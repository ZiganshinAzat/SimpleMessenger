//
//  WhiteButton.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 30.07.2024.
//

import UIKit

class SimpleButton: UIButton {

    var buttonText: String
    var completion: () -> Void
    var buttonColor: UIColor
    var titleColor: UIColor

    init(
        buttonText: String,
        buttonColor: UIColor = .white,
        titleColor: UIColor = .black,
        completion: @escaping () -> Void
    ) {
        self.buttonText = buttonText
        self.completion = completion
        self.buttonColor = buttonColor
        self.titleColor = titleColor
        super.init(frame: .zero)

        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        addAction(UIAction(handler: { [weak self] _ in
            guard let self = self else { return }
            completion()
        }), for: .touchUpInside)

        setTitle(buttonText, for: .normal)
        backgroundColor = buttonColor
        setTitleColor(titleColor, for: .normal)
        layer.cornerRadius = 10
    }
}
