//
//  TabBar.swift
//  SimpleMessenger
//
//  Created by Азат Зиганшин on 02.08.2024.
//

import UIKit

protocol TabBarViewProtocol: AnyObject {
    func setViewControllers(viewControllers: [UIViewController])
}

class TabBarView: UITabBarController, TabBarViewProtocol {
    
    var presenter: TabBarPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
    }

    func setViewControllers(viewControllers: [UIViewController]) {
        setViewControllers(viewControllers, animated: false)
    }
}
