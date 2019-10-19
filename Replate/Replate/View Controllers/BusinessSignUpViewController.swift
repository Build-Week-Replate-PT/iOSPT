//
//  BusinessSignUpViewController.swift
//  Replate
//
//  Created by Vici Shaweddy on 10/17/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import UIKit

class BusinessSignUpViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var businessNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityStateZipcodeTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    struct FirstForm {
        let username: String
        let email: String
        let password: String
        let confirmPassword: String
    }
    
    var firstForm: FirstForm?
    private let signUpController: SignUpController = SignUpController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide the navigation controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        // check if all textfields are filled
        guard let username = self.usernameTextField.text, !username.isEmpty,
            let email = self.emailTextField.text, !email.isEmpty,
            let password = self.passwordTextField.text, !password.isEmpty,
            let confirmPassword = self.confirmPasswordTextField.text, !confirmPassword.isEmpty else
        {
                let alert = UIAlertController(title: "Missing some fields", message: "Check your information and try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
        }
        
        // check if the password and the confirm password are match
        guard password == confirmPassword else {
            let alert = UIAlertController(title: "Password doesn't match", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // create the first form
        self.firstForm = FirstForm(username: username, email: email, password: password, confirmPassword: confirmPassword)
        
        // change to the second form
        self.performSegue(withIdentifier: "SecondFormSegue", sender: self)
    }
    
    @IBAction func createPressed(_ sender: Any) {
        // check if all textfields are filled
        guard let businessName = self.businessNameTextField.text, !businessName.isEmpty,
            let address = self.addressTextField.text, !address.isEmpty,
            let cityStateZipcode = self.cityStateZipcodeTextField.text, !cityStateZipcode.isEmpty,
            let phoneNumber = self.phoneNumberTextField.text, !phoneNumber.isEmpty else
        {
                let alert = UIAlertController(title: "Missing some fields", message: "Check your information and try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
        }
        
        // combine address and city, state, zipcode
        let fullAddress = "\(address),\(cityStateZipcode)"
        
        // create a signup request using signup controller
        guard let firstForm = self.firstForm else { return }
        let signUpRequest = SignUpRequest(username: firstForm.username, password: firstForm.password, organization_name: businessName, address: fullAddress, email: firstForm.email, phone: phoneNumber)
        
        signUpController.signUp(type: .business, with: signUpRequest) { (error) in
            DispatchQueue.main.async {
                if let _ = error {
                    let alert = UIAlertController(title: "Something wrong", message: "Please try again.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                } else {
                    // navigate to the business dashboard
                    self.performSegue(withIdentifier: "BusinessDashboardSegue", sender: self)
                }
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SecondFormSegue" {
            guard let vc = segue.destination as? BusinessSignUpViewController else { return }
            vc.firstForm = self.firstForm
        }
    }
}
