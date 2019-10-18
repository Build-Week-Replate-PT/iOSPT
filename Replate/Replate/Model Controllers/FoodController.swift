//
//  FoodController.swift
//  Replate
//
//  Created by Fabiola S on 10/17/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}

class FoodController {
    
    var donations: [Food] = []
    var token: Token?
    let baseURL = URL(string: "https://bw-replate.herokuapp.com/api/food")!
    
    func fetchBusinessDonations(completion: @escaping (Result<[String], NetworkError>) -> Void) {
        // Check for Business User Token
        guard let token = token else {
            completion(.failure(.noAuth))
            return
        }
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("Token \(token.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.badAuth))
                return
            }
            
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let donations = try decoder.decode([String].self, from: data)
                completion(.success(donations))
                
            } catch {
                print("Error decoding donations: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
        
    }
    
}
