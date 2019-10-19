//
//  BusinessLoginViewController.swift
//  Replate
//
//  Created by Michael Stoffer on 10/19/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import UIKit

class BusinessLoginViewController: UIViewController {
    
    // MARK: - Outlets and Properties
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    let loginController = LoginController()
    
    // MARK: - Actions and Methods
    @IBAction func login(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else { return }
        
        loginController.login(type: "business", withUsername: username, withPassword: password) { (error) in
            if let error = error {
                NSLog("Error occurred during login: \(error)")
            }
            
            self.usernameTextField.text = nil
            self.passwordTextField.text = nil
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BusinessLoginToDashboard" {
            guard let dashVC = segue.destination as? BusinessDashBoardTableViewController else { return }
            dashVC.loginController = self.loginController
        }
    }
}
