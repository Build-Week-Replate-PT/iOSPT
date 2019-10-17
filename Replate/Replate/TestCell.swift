//
//  TestCell.swift
//  Replate
//
//  Created by Fabiola S on 10/17/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import Foundation
import UIKit

class TestCell {
    
    var foodImage: UIImage
    var date: String
    var qty: Int
    var wasAccepted: Bool
    
    init(foodImage: UIImage, date: String, qty: Int, wasAccepted: Bool) {
        self.foodImage = foodImage
        self.date = date
        self.qty = qty
        self.wasAccepted = wasAccepted
    }
}
