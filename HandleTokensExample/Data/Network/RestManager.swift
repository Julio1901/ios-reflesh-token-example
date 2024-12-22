//
//  RestManager.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 12/12/24.
//

import Foundation

class RestManager {
    
    internal let baseUrl = URL(string: "http://127.0.0.1:8000")
    
    //TODO: Check if this needs to be removed and implement logic to fetch the access token.
    var accessToken : String = ""
    
    static let shared = RestManager()
    
    private init () {}
    
    
    enum EndPoint : String {
        case auth_token = "auth/token"
        case protected = "protected"
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
        //TODO: Create logic here to handle expired tokens, obtain new tokens, and log out the user if necessary.
        
    }
    
    
    


    
}
