//
//  Details.swift
//  HandleTokensExample
//
//  Created by Julio Cesar Pereira on 14/12/24.
//

import Foundation


extension RestManager {
    
    func getWelcomeMessage() {
        var url = self.baseUrl
        guard var url else { return }
        url.append(component: EndPoint.protected.rawValue)
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.get.rawValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
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
            if !(200...299).contains(httpResponse.statusCode) && httpResponse.statusCode != 401 {
                print("Network error!")
                return
            } else if httpResponse.statusCode == 401 {
                    print("Token expired")
                NotificationCenter.default.post(name: .showBottomSheet, object: nil)
                    return
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
    
}
