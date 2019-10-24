//
//  LoginController.swift
//  Replate
//
//  Created by Michael Stoffer on 10/17/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import Foundation

class LoginController {
    typealias CompletionHandler = (Error?) -> Void
    
    private let baseURL = URL(string: "https://bw-replate.herokuapp.com/api/auth/")!
    static var token: Token?
    
    func login(type: UserType, withUsername username: String, withPassword password: String, completion: @escaping CompletionHandler = { _ in }) {
        let requestURL = baseURL.appendingPathComponent("\(type.rawValue)/login")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let userParams = ["username": username, "password": password] as [String: Any]
            let json = try JSONSerialization.data(withJSONObject: userParams, options: .prettyPrinted)
            request.httpBody = json
        } catch {
            print("Error encoding user object: \(error)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error { completion(error); return }
            guard let data = data else { completion(NSError()); return }
            
            let decoder = JSONDecoder()
            
            do {
                LoginController.token = try decoder.decode(Token.self, from: data)
            } catch {
                print("Error decoding bearer object: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
}
