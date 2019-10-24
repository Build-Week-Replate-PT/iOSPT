//
//  SignUpController.swift
//  Replate
//
//  Created by Vici Shaweddy on 10/19/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import Foundation
import UIKit

class SignUpController {
    typealias CompletionHandler = (Error?) -> Void
    
    private let baseURL = URL(string: "https://bw-replate.herokuapp.com/api/auth")!
    
    // storing the objects from API
    var token: TokenResponse?
    
    // create function for sign up
    func signUp(type: UserType, with signupData: SignUpRequest, completion: @escaping CompletionHandler) {
        let signUpURL = baseURL.appendingPathComponent("/\(type.rawValue)/register")
        
        var request = URLRequest(url: signUpURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(signupData)
            request.httpBody = jsonData
        } catch {
            print("Error encoding business object: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 201 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.token = try decoder.decode(TokenResponse.self, from: data)
            } catch {
                print("Error decoding token object: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
}

