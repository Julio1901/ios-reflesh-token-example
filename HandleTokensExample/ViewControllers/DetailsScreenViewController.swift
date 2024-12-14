//
//  DetailsScreenViewController.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 14/12/24.
//

import UIKit

class DetailsScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    

}

extension DetailsScreenViewController {
    
    func addSubviews() {
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
    
    @objc func makegenericRequest() {
        print("make generic request")
    }
}
