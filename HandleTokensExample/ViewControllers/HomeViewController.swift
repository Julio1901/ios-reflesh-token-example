//
//  HomeViewController.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 23/11/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    let mainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewModel.getWelcomeMessage()
    }
}
