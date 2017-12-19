//
//  MenuListTableViewCell.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta on 04/12/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class MenuListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var labelGst: DesignableLabel!
    @IBOutlet weak var labelPrice: DesignableLabel!
    @IBOutlet weak var labelSpecial: DesignableLabel!
    @IBOutlet weak var labelName: DesignableLabel!
    @IBOutlet weak var labelNo: DesignableLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelNo.text = Localizator.instance.localize(string: "Key_labelNo")
        self.labelName.text = Localizator.instance.localize(string: "Key_customerName")
        self.labelPrice.text = Localizator.instance.localize(string: "Key_labelPrize")
        self.labelGst.text = Localizator.instance.localize(string: "Key_labelGst")
        self.labelSpecial.text = Localizator.instance.localize(string: "Key_labelSpecial")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
