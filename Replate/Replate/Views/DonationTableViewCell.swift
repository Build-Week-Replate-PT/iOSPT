//
//  DonationTableViewCell.swift
//  Replate
//
//  Created by Fabiola S on 10/17/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import UIKit

class DonationTableViewCell: UITableViewCell {
    
    var food: Food? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var donationImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var hasBeenAcceptedLabel: UILabel!
    

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
        
       
    }

}
