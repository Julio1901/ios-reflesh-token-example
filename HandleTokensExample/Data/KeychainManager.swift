//
//  KeychainManager.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 24/11/24.
//

import Foundation
import Security

enum KeychainManagerKeys: String {
    case reflesh_token = "reflesh_token"
}

final class KeychainManager: SecureStorage {
    
    static let shared = KeychainManager()
    
    private init () {}
    
    func saveToken(_ token: String, for key: KeychainManagerKeys) -> Bool {
        let data = Data(token.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        // Remove qualquer entrada existente
        SecItemDelete(query as CFDictionary)
        
        // Adiciona o novo token
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    func getToken(for key: KeychainManagerKeys) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func deleteToken(for key: KeychainManagerKeys) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
