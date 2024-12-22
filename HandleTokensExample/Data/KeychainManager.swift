//
//  KeychainManager.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 24/11/24.
//

import Foundation
import Security


final class KeychainManager: SecureStorage {
    
    static let shared = KeychainManager()
    
    private init () {}
    
    func saveToken(_ token: String, for key: KeychainKey) -> Bool {
        let data = Data(token.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: data
        ]
        
        
        SecItemDelete(query as CFDictionary)
        
   
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    func getToken(for key: KeychainKey) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
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
    
    func deleteToken(for key: KeychainKey) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
    
    
    static func set<T: Encodable>(value: T, key: KeychainKey, accessGroup: String? = nil) -> Bool {

        guard let valueData = try? JSONEncoder().encode(value) else { return false }
        

        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: valueData
        ]
        
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup
        }
        

        let _ = SecItemDelete(query as CFDictionary)
        
     
        let status = SecItemAdd(query as CFDictionary, nil)
        
        return status == errSecSuccess
    }
    
    static func get(key: KeychainKey, accessGroup: String? = nil) -> Bool? {

        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: kCFBooleanTrue as Any,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup
        }
        

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess, let data = result as? Data else {
            return nil
        }
        
     
        let decodedValue = try? JSONDecoder().decode(Bool.self, from: data)
        
        return decodedValue
    }

     static func remove(key: KeychainKey, accessGroup: String? = nil) -> Bool {
         var query: [String: Any] = [
             kSecClass as String: kSecClassGenericPassword,
             kSecAttrAccount as String: key.rawValue
         ]
         
         if let accessGroup = accessGroup {
             query[kSecAttrAccessGroup as String] = accessGroup
         }
         
         let status = SecItemDelete(query as CFDictionary)
         return status == errSecSuccess
        
    }
}
