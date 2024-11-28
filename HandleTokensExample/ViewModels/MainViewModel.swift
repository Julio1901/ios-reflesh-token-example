//
//  MainViewModel.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 23/11/24.
//

import Foundation

struct MainViewModel {
    
    let networkClient = NetworkClient()
    
    var userLoggedSuccessfully: ((Bool) -> Void)?
    
    func logIn(userName: String, password: String, completion: @escaping () -> Void) async {
        await networkClient.authenticate(userName: userName, password: password)
        completion()
    }
    
    func getWelcomeMessage() {
        networkClient.getWelcomeMessage()
    }
    
    
}
