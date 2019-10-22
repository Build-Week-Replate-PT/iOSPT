//
//  FoodController.swift
//  Replate
//
//  Created by Fabiola S on 10/17/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import Foundation

class FoodController {
    
    // MARK: Properties
    typealias CompletionHandler = (Result<[String], NetworkError>) -> Void
    var donations: [Food] = []
    var token: Token?
    let baseURL = URL(string: "https://bw-replate.herokuapp.com/api/food")!
    
    // MARK: Fetch all items function
    func fetchAllDonations(completion: @escaping CompletionHandler) {
        // Check for User Token
        guard let token = token else {
            completion(.failure(.noAuth))
            return
        }
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.get.rawValue
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
    
    // MARK: Business User functions
    func fetchBusinessDonations(completion: @escaping CompletionHandler) {
        guard let token = token else {
            completion(.failure(.noAuth))
            return
        }
        
        let businessDonationsURL = baseURL.appendingPathComponent("business")
        var request = URLRequest(url: businessDonationsURL)
        request.httpMethod = HTTPMethod.get.rawValue
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
                print("Error decoding business donations: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    func createDonation(with donation: Food, completion: @escaping (Result<Food, NetworkError>) -> Void) {
        guard let token = token else {
            completion(.failure(.noAuth))
            return
        }
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601
        do {
            
            let jsonData = try jsonEncoder.encode(donation)
            request.httpBody = jsonData
            print(donation)
        } catch {
            print("Error encoding gig object: \(error.localizedDescription)")
            completion(.failure(.otherError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.badAuth))
            }
            
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            self.donations.append(donation)
            completion(.success(donation))
            
        }.resume()
    }
    
    
    
    
    // MARK: Volunteer user functions
    
}
