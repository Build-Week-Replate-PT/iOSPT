//
//  Extensions.swift
//  Replate
//
//  Created by Vici Shaweddy on 10/21/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    func shouldRemoveShadow(_ value: Bool) -> Void {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
}
