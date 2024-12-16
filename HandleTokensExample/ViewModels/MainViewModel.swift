//
//  MainViewModel.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 23/11/24.
//

import Foundation

struct MainViewModel {
    
    let rest = RestManager.shared
    
    var userLoggedSuccessfully: ((Bool) -> Void)?
    
    func logIn(userName: String, password: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) async {
        await rest.authenticate(userName: userName, password: password) { result in
            
            //TODO: Aqui, eu não precisava passar essas infos para a viewController. Só fiz a título de estudo.
            switch result {
            case .success(let response): completion(.success(response))
                
            case .failure(let error):
                debugPrint("Authenticate failed")
                completion(.failure(error))
                
            }
        }
    }
    
    func getWelcomeMessage() async {
        await rest.getWelcomeMessage()
    }
    
}
