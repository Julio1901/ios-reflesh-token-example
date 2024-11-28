//
//  SecureStorage.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 24/11/24.
//

import Foundation

protocol SecureStorage {
    func saveToken(_ token: String, for key: KeychainManagerKeys) -> Bool
    func getToken(for key: KeychainManagerKeys) -> String?
    func deleteToken(for key: KeychainManagerKeys) -> Bool
}
