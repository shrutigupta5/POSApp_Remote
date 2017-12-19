//
//  AddEmployeeListTableViewCell.swift
//  POSApp
//
//  Created by webwerks on 14/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class AddEmployeeListTableViewCell: UITableViewCell {

    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var labelPassword: UILabel!
    @IBOutlet weak var viewRole: UIView!
    @IBOutlet weak var labelRole: UILabel!
    @IBOutlet weak var viewContact: UIView!
    @IBOutlet weak var labelContact: UILabel!
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var viewRate: UIView!
    @IBOutlet weak var labelRate: UILabel!
    @IBOutlet weak var viewHourly: UIView!
    @IBOutlet weak var labelHourly: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       localization()
    }
    func localization()
    {
        self.labelName.text = Localizator.instance.localize(string: "Key_customerName")
        self.labelPassword.text = Localizator.instance.localize(string: "Key_customerPassword")
        self.labelRole.text = Localizator.instance.localize(string: "Key_role")
        self.labelContact.text = Localizator.instance.localize(string: "Key_customerContact")
        self.labelAddress.text = Localizator.instance.localize(string: "Key_customerAddress")
        self.labelRate.text = Localizator.instance.localize(string: "Key_customerRate")
        self.labelHourly.text = Localizator.instance.localize(string: "Key_customerHourly")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
