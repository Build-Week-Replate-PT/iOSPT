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
    
    let loginController = LoginController.shared
    var foodController: FoodController?
    
    override func viewDidLoad() {
        // hide the navigation bar line
        self.navigationController?.navigationBar.shouldRemoveShadow(true)
    }
    
    // MARK: - Actions and Methods
    @IBAction func login(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else { return }
        
        loginController.login(type: .business, withUsername: username, withPassword: password) { (error) in
            if let error = error {
                NSLog("Error occurred during login: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func backToSignUp(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
