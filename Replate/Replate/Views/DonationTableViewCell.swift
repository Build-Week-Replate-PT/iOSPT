//
//  DonationTableViewCell.swift
//  Replate
//
//  Created by Fabiola S on 10/17/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import UIKit

protocol DonationTableViewCellDelegate: AnyObject {
    func claimButtonPressed(food: Food)
}

class DonationTableViewCell: UITableViewCell {
    
    var food: Food? {
        didSet {
            self.isClaimedLocal = food?.is_claimed == 1
            updateViews()
        }
    }
    
    var isClaimedLocal: Bool  = false
    
    weak var delegate: DonationTableViewCellDelegate?

    @IBOutlet weak var donationImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var hasBeenAcceptedLabel: UILabel!
    @IBOutlet weak var claimButton: UIButton!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateViews() {
        self.donationImage.image = UIImage(named: "pizza") ?? UIImage()
        self.nameLabel.text = food?.name
        self.descriptionTextView.text = food?.description
        
        if self.isClaimedLocal {
            self.claimButton.setTitle("Claimed", for: .normal)
            self.claimButton.backgroundColor = UIColor(red: 226/255, green: 162/255, blue: 106/255, alpha: 1.0)
        } else {
            self.claimButton.setTitle("Accept", for: .normal)
            self.claimButton.backgroundColor = UIColor(red: 45/255, green: 145/255, blue: 76/255, alpha: 1.0)
        }
    }

    @IBAction func claimPressed(_ sender: Any) {
        self.isClaimedLocal.toggle()
        updateViews()
        if let food = food {
            self.delegate?.claimButtonPressed(food: food)
        }
    }
}
