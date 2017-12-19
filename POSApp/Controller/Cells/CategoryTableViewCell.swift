//
//  CategoryTableViewCell.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta on 04/12/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var labelNo: UILabel!
    @IBOutlet weak var labelCategoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelCategoryName.text = Localizator.instance.localize(string: "Key_Category")
        self.labelNo.text = Localizator.instance.localize(string: "Key_labelNo")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
