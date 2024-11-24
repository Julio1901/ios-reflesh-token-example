//
//  ViewController.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 23/11/24.
//

import UIKit

class ViewController: UIViewController {

    let mainViewModel = MainViewModel()
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func logInBtnAction(_ sender: Any) {
        handleLogInClick()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func handleLogInClick() {
        let userName = userNameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Task{
            self.mainViewModel.logIn(userName: userName, password: password)
        }
        
        
//        if userName == "julio" && password == "admin123" {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
//                navigationController?.pushViewController(homeViewController, animated: true)
//                print("Validate!")
//            }
//        }
    }
    
}

