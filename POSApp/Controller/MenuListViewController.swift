//
//  MenuListViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta on 01/12/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class MenuListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var viewMenuItem: DesignableView!
    @IBOutlet weak var viewCategory: UIView!
    @IBOutlet weak var tableViewMenuItems: UITableView!
    @IBOutlet weak var tableViewCategory: UITableView!
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var labelMenuItem: UILabel!
    @IBOutlet weak var labelHashCategory: UILabel!
    @IBOutlet weak var labelNo: DesignableLabel!
    @IBOutlet weak var labelName: DesignableLabel!
    @IBOutlet weak var labelPrize: DesignableLabel!
    @IBOutlet weak var labelGst: DesignableLabel!
    @IBOutlet weak var labelSpecial: DesignableLabel!
    @IBOutlet weak var labelLowerCaregory: UILabel!
    @IBOutlet weak var labelLowerName: UILabel!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var labelMenu: UILabel!
    @IBOutlet weak var labelMenuName: UILabel!
    @IBOutlet weak var textFieldMenuName: UITextField!
    @IBOutlet weak var labelMenuPrice: UILabel!
    @IBOutlet weak var textFieldPriceMenu: UITextField!
    @IBOutlet weak var labelMenuSpecial: UILabel!
    @IBOutlet weak var labelMenuGst: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        setCustomColor()
        setUpView()
        
        // Do any additional setup after loading the view.
    }
    func localization()
    {
        self.labelCategory.text = Localizator.instance.localize(string: "Key_Category")
        self.labelMenuItem.text = Localizator.instance.localize(string: "Key_menuItem")
        self.labelHashCategory.text = Localizator.instance.localize(string: "Key_Category")
        self.labelNo.text = Localizator.instance.localize(string: "Key_labelNo")
        self.labelName.text = Localizator.instance.localize(string: "Key_customerName")
        self.labelPrize.text = Localizator.instance.localize(string: "Key_labelPrize")
        self.labelGst.text = Localizator.instance.localize(string: "Key_labelGst")
        self.labelSpecial.text = Localizator.instance.localize(string: "Key_labelSpecial")
        self.labelLowerCaregory.text = Localizator.instance.localize(string: "Key_Category")
        self.labelLowerName.text = Localizator.instance.localize(string: "Key_customerName")
        self.labelMenu.text = Localizator.instance.localize(string: "Key_labelMenu")
        self.labelMenuName.text = Localizator.instance.localize(string: "Key_customerName")
        self.labelMenuPrice.text = Localizator.instance.localize(string: "Key_labelPrize")
        self.labelMenuSpecial.text = Localizator.instance.localize(string: "Key_labelSpecial")
         self.labelMenuGst.text = Localizator.instance.localize(string: "Key_labelGst")
    }
    // nib register for menu and category cell
    func setUpView(){
        
    tableViewCategory.delegate = self
    tableViewMenuItems.delegate = self
    tableViewCategory.dataSource = self
    tableViewMenuItems.dataSource = self
    tableViewMenuItems.register(UINib(nibName: "MenuListTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuListTableViewCell")
    tableViewCategory.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    
    func setCustomColor(){
    
        self.viewCategory.backgroundColor = UIColor.customblack
        self.viewMenuItem.backgroundColor = UIColor.lightGray
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if (tableView == tableViewCategory) && tableView == tableViewMenuItems {
            
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tableViewCategory {
            return 10
        }
        else if (tableView == tableViewMenuItems) {
            return 10
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == tableViewCategory)
        {
        let categoryCell = tableViewCategory.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as! CategoryTableViewCell
              return categoryCell
        }
        else{
        
            let menuListCell = tableViewMenuItems.dequeueReusableCell(withIdentifier: "MenuListTableViewCell") as! MenuListTableViewCell
            return menuListCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView == tableViewCategory)
        {
           return 90
        }
        else{
            
            return 70
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionSpecialButton(_ sender: Any) {
    }
    
    @IBAction func actionGstButton(_ sender: Any) {
    }
    

}
