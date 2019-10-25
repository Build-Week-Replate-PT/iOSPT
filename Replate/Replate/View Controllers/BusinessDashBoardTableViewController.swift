//
//  BusinessDashBoardTableViewController.swift
//  Replate
//
//  Created by Fabiola S on 10/17/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import UIKit

class BusinessDashBoardTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var loginController = LoginController.shared
    var foodController = FoodController()
    
    var donations = [
        Donation(foodImage: UIImage(named: "pizza") ?? UIImage(), date: "Thursday, October 17", qty: 2, wasAccepted: true)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.leftBarButtonItem = nil
        
        if loginController.token == nil {
            performSegue(withIdentifier: "signUpBusiness", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
               
        foodController.fetchBusinessDonations { (result) in
            if let createdDonations = try? result.get() {
                DispatchQueue.main.async {
                    self.foodController.donations = createdDonations
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodController.donations.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "donationsCell", for: indexPath) as? DonationTableViewCell else { fatalError("Error getting donation data")}
            cell.food = self.foodController.donations[indexPath.row]
            return cell

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "donationDetailSegue" {
                  if let detailVC = segue.destination as? DonationDetailViewController {
                      guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
                      detailVC.foodController = foodController
                    detailVC.donation = foodController.donations[selectedIndexPath.row]
                  }
              } else if segue.identifier == "createDonationSegue" {
                if let addVC = segue.destination as? AddEditDonationViewController {
                    addVC.foodController = foodController
                }
        }
    }

}
