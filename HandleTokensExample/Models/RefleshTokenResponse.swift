//
//  RefleshTokenResponse.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 24/11/24.
//

import Foundation

struct RefreshTokenResponse: Codable {
    let accessToken: String
    let tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}
