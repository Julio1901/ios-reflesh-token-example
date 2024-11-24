//
//  MainViewModel.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 23/11/24.
//

import Foundation

struct MainViewModel {
    
    let networkClient = NetworkClient()
    
    func logIn(userName: String, password: String) {
        networkClient.authenticate(userName: userName, password: password)
    }
    
    
}
