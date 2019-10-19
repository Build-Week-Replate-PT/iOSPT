//
//  SignUpRequest.swift
//  Replate
//
//  Created by Vici Shaweddy on 10/19/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import Foundation

// The request is different from the response
struct SignUpRequest: Equatable, Codable {
    var username: String
    var password: String
    var organization_name: String
    var address: String
    var email: String
    var phone: Int
}
