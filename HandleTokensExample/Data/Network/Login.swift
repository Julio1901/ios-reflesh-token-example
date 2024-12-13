//
//  Login.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 12/12/24.
//

import Foundation

extension RestManager {

    func authenticate(userName: String, password: String, completion: @escaping (Result<AuthResponse, RestManagerError>) -> Void) async {
        //TODO: Depois, aprender como fazer ambientes diferentes
//        var url = self.baseUrl
//        guard var url else { return }
//        url = url.appendingPathComponent(EndPoint.auth_token.rawValue)
        
        var url = self.baseUrl
        guard var url else { return }
        url.append(component: EndPoint.auth_token.rawValue)

        print("test \(url)")
        
       let parameters = [
           "username": userName,
           "password": password
       ]
       

       let bodyString = parameters.map { "\($0.key)=\($0.value)" }
                                   .joined(separator: "&")
       

       var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.post.rawValue
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
           if !(200...299).contains(httpResponse.statusCode) {
               print("Authenticated Error!")
               completion(.failure(.unknownError))
               return
           } else if httpResponse.statusCode == 401 {
                   print("Incorrect username or password")
                    completion(.failure(.unauthorized))
                   return
           }
           if let data = data {
               do {
                   //TODO: Remover isso
                   if let jsonString = String(data: data, encoding: .utf8) {
                       print("Response JSON TEST: \(jsonString)")
                   }
                   
                   let decoder = JSONDecoder()
                   let authResponse = try decoder.decode(AuthResponse.self, from: data)
                   
                   
                   
                   print("Access Token: \(authResponse.accessToken)")
                   print("Refresh Token: \(authResponse.refreshToken)")
                   print("Token Type: \(authResponse.tokenType)")
    
                   self.accessToken = authResponse.accessToken
                   KeychainManager.shared.saveToken(authResponse.refreshToken, for: .reflesh_token)
                   completion(.success(authResponse))
               } catch {
                   print("Decoding error: \(error.localizedDescription)")
               }
           }
       }
       
       task.resume()
   }
}
