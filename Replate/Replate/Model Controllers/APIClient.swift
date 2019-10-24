//
//  APIClient.swift
//  Replate
//
//  Created by Vici Shaweddy on 10/19/19.
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

enum UserType: String {
    case business
    case volunteer
}
