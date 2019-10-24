//
//  VolunteerLoginViewController.swift
//  Replate
//
//  Created by Michael Stoffer on 10/19/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import UIKit

class VolunteerLoginViewController: UIViewController {
    
    // MARK: - Outlets and Properties
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    var loginController = LoginController.shared
    
    override func viewDidLoad() {
        // hide the navigation bar line
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
    }
    
    // MARK: - Actions and Methods
    
    @IBAction func login(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else { return }
        
        loginController.login(type: .volunteer, withUsername: username, withPassword: password) { (error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    NSLog("Error occurred during login: \(error)")
                } else {
                    self.usernameTextField.text = nil
                    self.passwordTextField.text = nil
                    self.performSegue(withIdentifier: "VolunteerLoginToDashboard", sender: self)
                }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "VolunteerLoginToDashboard" {
//
//        }
//    }
}
