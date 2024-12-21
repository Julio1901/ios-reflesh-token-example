//
//  Coordinator.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 21/12/24.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
