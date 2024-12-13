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
