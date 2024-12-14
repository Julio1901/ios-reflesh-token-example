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
//        view.addSubview(GenericBottomSheet())
        mainViewModel.getWelcomeMessage()
        self.addSubviews()
      
    }
}

extension HomeViewController {
    
    func addSubviews() {
        let buttonGoToDetailsScreen = UIButton(type: .system)
        buttonGoToDetailsScreen.setTitle("Go to details Screen", for: .normal)
        buttonGoToDetailsScreen.tintColor = .blue
        buttonGoToDetailsScreen.translatesAutoresizingMaskIntoConstraints = false
        buttonGoToDetailsScreen.addTarget(self, action: #selector(navigateToDetailsScreen), for: .touchUpInside)
        view.addSubview(buttonGoToDetailsScreen)
        buttonGoToDetailsScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        buttonGoToDetailsScreen.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonGoToDetailsScreen.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonGoToDetailsScreen.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        
        let buttonMakegenericRequest = UIButton(type: .system)
        buttonMakegenericRequest.setTitle("Call generic request", for: .normal)
        buttonMakegenericRequest.tintColor = .blue
        buttonMakegenericRequest.translatesAutoresizingMaskIntoConstraints = false
        buttonMakegenericRequest.addTarget(self, action: #selector(makegenericRequest), for: .touchUpInside)
        view.addSubview(buttonMakegenericRequest)
        buttonMakegenericRequest.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300).isActive = true
        buttonMakegenericRequest.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonMakegenericRequest.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonMakegenericRequest.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        
    }
    

    @objc func navigateToDetailsScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsViewController = storyboard.instantiateViewController(withIdentifier: "DetailsScreenViewController") as? DetailsScreenViewController {
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
    
    @objc func makegenericRequest() {
        print("make generic request")
    }
    
}
