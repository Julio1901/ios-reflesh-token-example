//
//  AppCoordinator.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 21/12/24.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController


    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if UserManager.shared.isLogged {
            showHome()
        } else {
            showLogin()
        }
    }

    func showLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            self.navigationController.pushViewController(loginViewController, animated: true)
        }

    }

    func showHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            self.navigationController.pushViewController(homeViewController, animated: true)
        }
    }
}
