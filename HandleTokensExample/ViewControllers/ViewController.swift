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
//        view.addSubview(GenericBottomSheet())
    }
    
    @objc func handleLogInClick() {
        let userName = userNameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Task {
            await self.mainViewModel.logIn(userName: userName, password: password, completion: { [weak self] loginSucess in
                switch loginSucess {
                    case .success(_):   self?.navigateToHome()
                    case .failure(_):   debugPrint("Realizar tratativa para exibir mensagem de erro de autenticação")
                }
            })
        }
    }

    // A função de navegação foi movida para dentro da classe ViewController
    func navigateToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            // Verifique se a navegação está disponível e, se sim, faça o push
            DispatchQueue.main.sync {
                self.navigationController?.pushViewController(homeViewController, animated: true)
//                print("Validate!")
            }
        }
    }
}
