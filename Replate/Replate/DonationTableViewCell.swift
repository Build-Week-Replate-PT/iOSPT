//
//  DonationTableViewCell.swift
//  Replate
//
//  Created by Fabiola S on 10/17/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import UIKit

class DonationTableViewCell: UITableViewCell {
    
    var testCell: TestCell? {
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
        guard let qty = testCell?.qty else { return }
        donationImage.image = testCell?.foodImage
        dateLabel.text = testCell?.date
        qtyLabel.text = String(qty)
        
       
    }

}
