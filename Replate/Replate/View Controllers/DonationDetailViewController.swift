//
//  DonationDetailViewController.swift
//  Replate
//
//  Created by Fabiola S on 10/17/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import UIKit

class DonationDetailViewController: UIViewController {
    
    // MARK: Properties
    var foodController = FoodController()
    var donation: Food?
    
    // MARK: Outlets
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var businessAddressLabel: UILabel!
    @IBOutlet weak var pickupDateLabel: UILabel!
    @IBOutlet weak var donationDescriptionTextView: UITextView!
    @IBOutlet weak var businessPhoneLabel: UILabel!
    @IBOutlet weak var pickupTimeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let donation = donation else {
            title = "New Donation"
            return
        }
        
        // Missing getting Logged in user's information
        pickupDateLabel.text = donation.pickup_date
        donationDescriptionTextView.text = donation.description
        pickupTimeLabel.text = donation.time
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
