//
//  NetworkClient.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 23/11/24.
//

import Foundation

class NetworkClient {
    
    private let BASE_URL = "http://127.0.0.1:8000/"
    
    var accessToken : String?
    
     func authenticate(userName: String, password: String) async {
        // Endpoint URL
        guard let url = URL(string: "\(BASE_URL)auth/token") else {
            print("Invalid URL")
            return
        }
        
 
        let parameters = [
            "username": userName,
            "password": password
        ]
        

        let bodyString = parameters.map { "\($0.key)=\($0.value)" }
                                    .joined(separator: "&")
        

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyString.data(using: .utf8)
        

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
                    
                    self.accessToken = authResponse.accessToken
                    KeychainManager.shared.saveToken(authResponse.refreshToken, for: .reflesh_token)
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
 
    
    
    func getWelcomeMessage() {

        guard let url = URL(string: "\(BASE_URL)protected") else {
            print("Invalid URL")
            return
        }
        

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            if httpResponse.statusCode == 401 {
                self.refreshAccessToken {
                    self.getWelcomeMessage()
                }
            }
  
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let protectedResponse = try decoder.decode(ProtectedRouteResponse.self, from: data)
                    print("Message: \(protectedResponse.message)")
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
    
    
    
    func refreshAccessToken(completion: @escaping () -> Void) {
        let refreshToken = KeychainManager.shared.getToken(for: .reflesh_token)
        
        guard let url = URL(string: "\(BASE_URL)auth/refresh?refresh_token=\(refreshToken)") else {
            print("Invalid URL")
            return
        }
        
        // Criar a requisição
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Configurar a sessão
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            // Decodificar o JSON
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let refreshResponse = try decoder.decode(RefreshTokenResponse.self, from: data)
                    print("New Access Token: \(refreshResponse.accessToken)")
                    self.accessToken = refreshResponse.accessToken
                    completion()
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
    
}
