//
//  ProfileTableViewCell.swift
//  POSApp
//
//  Created by webwerks on 08/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var labelFirstName: UILabel!
   
    @IBOutlet weak var labelEmailAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewProfile.layer.cornerRadius = imageViewProfile.layer.frame.height/2
        imageViewProfile.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
