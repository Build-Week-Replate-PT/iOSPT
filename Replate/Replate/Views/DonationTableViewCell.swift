//
//  DonationTableViewCell.swift
//  Replate
//
//  Created by Fabiola S on 10/17/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import UIKit

class DonationTableViewCell: UITableViewCell {
    
    var donationCell: DonationCell? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var donationImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var hasBeenAcceptedLabel: UILabel!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        guard let qty = donationCell?.qty else { return }
        donationImage.image = donationCell?.foodImage
        dateLabel.text = donationCell?.date
        qtyLabel.text = String(qty)
        
       
    }

}
