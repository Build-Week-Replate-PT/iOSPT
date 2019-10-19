//
//  Volunteer.swift
//  Replate
//
//  Created by Michael Stoffer on 10/17/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import Foundation

struct VolunteerUser: Equatable, Codable {
    var user: Volunteer
}

struct Volunteer: Equatable, Codable {
    var id: Int
    var username: String
    var password: String
    var organization_name: String
    var address: String
    var email: String
    var phone: String
}

