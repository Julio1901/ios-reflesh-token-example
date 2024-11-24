//
//  NetworkClient.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 23/11/24.
//

import Foundation

class NetworkClient {
    
    
    func authenticate(userName: String, password: String) {
        // Endpoint URL
        guard let url = URL(string: "http://127.0.0.1:8000/auth/token") else {
            print("Invalid URL")
            return
        }
        
        // Parâmetros para a requisição
        let parameters = [
            "username": userName,
            "password": password
        ]
        
        // Codificar os parâmetros como x-www-form-urlencoded
        let bodyString = parameters.map { "\($0.key)=\($0.value)" }
                                    .joined(separator: "&")
        
        // Criar a requisição
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyString.data(using: .utf8)
        
        // Configurar a sessão
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            if (200...299).contains(httpResponse.statusCode) {
                print("Authenticated successfully!")
            } else if httpResponse.statusCode == 401 {
                    print("Incorrect username or password")
                    return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let authResponse = try decoder.decode(AuthResponse.self, from: data)
                    print("Access Token: \(authResponse.accessToken)")
                    print("Refresh Token: \(authResponse.refreshToken)")
                    print("Token Type: \(authResponse.tokenType)")
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
    
}
