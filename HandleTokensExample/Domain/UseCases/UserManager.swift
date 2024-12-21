//
//  UserManager.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 21/12/24.
//

import Foundation

final class UserManager {
    
    static let shared = UserManager()
    
    private init () {}
    
    public var isLogged: Bool {
        get {
            guard let hasItem: Bool = KeychainManager.get(key: .user_logged) else { return false }
            
            return hasItem
        }
        
        set {
           _ = KeychainManager.set(value: newValue, key: .user_logged)
        }
    }
    
    func logOut() {
        _ = KeychainManager.remove(key: .user_logged)
    }
}
