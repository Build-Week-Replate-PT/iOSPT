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
    var loginController = LoginController.shared
    let baseURL = URL(string: "https://bw-replate.herokuapp.com/api/food")!
    
    // MARK: Business User functions
    // List all donations created by user
    func fetchBusinessDonations(completion: @escaping CompletionHandler) {
        let businessDonationsURL = baseURL.appendingPathComponent("business")
        var request = URLRequest(url: businessDonationsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue(LoginController.shared.token!.token, forHTTPHeaderField: "Authorization")
        
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
    
    // User can create a new donation
    func createDonation(withName name: String, withPickupDate pickupDate: String, withTime time: String, withDescription description: String, completion: @escaping (Result<Food, NetworkError>) -> Void) {
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(LoginController.shared.token!.token, forHTTPHeaderField: "Authorization")

        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = .iso8601
        do {
            let userParams = ["name": name, "time": time, "description": description, "is_claimed": 0, "pickup_date": pickupDate] as [String: Any]
            let json = try JSONSerialization.data(withJSONObject: userParams, options: .prettyPrinted)
            request.httpBody = json
        } catch {
            print("Error encoding gig object: \(error.localizedDescription)")
            completion(.failure(.otherError))
            return
        }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.badAuth))
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
                let donation = try decoder.decode(Food.self, from: data)
                self.donations.append(donation)
                completion(.success(donation))
            } catch {
                print("Error decoding donation after creating: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    // User can update a saved donation
//    func updateDonation(with donation: Food, completion: @escaping (Result<Food, NetworkError>) -> Void) {
//        guard let token = token else {
//            completion(.failure(.noAuth))
//            return
//        }
//
//        let updateDonationURL = baseURL.appendingPathComponent("\(donation.id)")
//        var request = URLRequest(url: updateDonationURL)
//        request.httpMethod = HTTPMethod.put.rawValue
//        request.addValue(token.token, forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        do {
//            let userParams = ["id": donation.id, "message": message] as [String: Any]
//            let json = try JSONSerialization.data(withJSONObject: userParams, options: .prettyPrinted)
//            request.httpBody = json
//        } catch {
//            print("Error encoding item object: \(error)")
//        }
//
//        URLSession.shared.dataTask(with: request) { (_, response, error) in
//            if let response = response as? HTTPURLResponse,
//                response.statusCode == 401 {
//                completion(.failure(.badAuth))
//            }
//
//            if let _ = error {
//                completion(.failure(.otherError))
//                return
//            }
//
//            completion(nil)
//        }.resume()
//    }
    
    // User can delete a saved donation
    func deleteDonation(with donation: Food, completion: @escaping (Result<[Food], NetworkError>) -> Void) {
        let requestURL = baseURL.appendingPathComponent("\(donation.id)")

        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.addValue(LoginController.shared.token!.token, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.badAuth))
                return
            }
            
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
        }.resume()
    }
    
    // MARK: Volunteer user functions
    
    // List all donations created by business users
    func fetchAllDonations(completion: @escaping (Result<[Food], NetworkError>) -> Void) {
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue(LoginController.shared.token!.token, forHTTPHeaderField: "Authorization")
        
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
                let donations = try decoder.decode([Food].self, from: data)
                completion(.success(donations))

            } catch {
                print("Error decoding donations: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
        
    }
    
    // List all donations claimed by volunteer
    func fetchClaimedDonations(completion: @escaping CompletionHandler) {
        let claimedDonationsURL = baseURL.appendingPathComponent("volunteer")
        var request = URLRequest(url: claimedDonationsURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue(LoginController.shared.token!.token, forHTTPHeaderField: "Authorization")
        
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
                print("Error decoding claimed donations: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    // User can claim a donation
    
}
