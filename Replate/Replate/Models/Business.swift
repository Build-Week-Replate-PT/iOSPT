//
//  Business.swift
//  Replate
//
//  Created by Michael Stoffer on 10/17/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import Foundation

// The response
struct BusinessUser: Equatable, Codable {
    var user: Business
}

struct Business: Equatable, Codable {
    var id: Int
    var username: String
    var password: String
    var organization_name: String
    var address: String
    var email: String
    var phone: String
}
