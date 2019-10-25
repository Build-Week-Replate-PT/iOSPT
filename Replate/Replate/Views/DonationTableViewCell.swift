//
//  DonationTableViewCell.swift
//  Replate
//
//  Created by Fabiola S on 10/17/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import UIKit

protocol DonationTableViewCellDelegate: AnyObject {
    func claimButtonPressed(is_claimed: Bool)
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
//        guard let qty = donation?.qty else { return }
        self.donationImage.image = UIImage(named: "pizza") ?? UIImage()
        self.nameLabel.text = food?.name
        self.descriptionTextView.text = food?.description
//        dateLabel.text = donation?.date
//        qtyLabel.text = String(qty)
        
        if self.isClaimedLocal {
            self.claimButton.setTitle("Claimed", for: .normal)
        } else {
            self.claimButton.setTitle("Accept", for: .normal)
        }
    }

    @IBAction func claimPressed(_ sender: Any) {
        self.isClaimedLocal.toggle()
        updateViews()
        self.delegate?.claimButtonPressed(is_claimed: self.isClaimedLocal)
    }
}
