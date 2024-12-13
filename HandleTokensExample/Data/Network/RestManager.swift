//
//  RestManager.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 12/12/24.
//

import Foundation

class RestManager {
    
    internal let baseUrl = URL(string: "http://127.0.0.1:8000")
    
    //TODO: Verficar se precisa remover isso e fazer lógica que pega o access token
    var accessToken : String?
    
    enum EndPoint : String {
        case auth_token = "auth/token"
    }
    
    enum HttpMethod: String {
        case get
        case post
        case put
        case patch
        case delete
    }
    
    public enum RestManagerError: Error {
        case networkError
        case unauthorized
        case unknownError
    }
    
    
    func makeRequest() {
        //TODO: Criar aqui lógica para lidar com tokens expirados, obtenção de novos tokens e deslogar usuário se necessário
        
    }
    
    
    


    
}
