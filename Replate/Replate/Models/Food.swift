//
//  Food.swift
//  Replate
//
//  Created by Michael Stoffer on 10/17/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import Foundation

struct Food: Equatable, Codable {
    var name: String
    var time: String
    var description: String
    var is_claimed: Bool
    var pickup_date: Date
    var business_id: Int
    var volunteer_id: Int
    
}
