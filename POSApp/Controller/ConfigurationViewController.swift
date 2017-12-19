//
//  ConfigurationViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta  on 29/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController {

    @IBOutlet weak var buttonPrint: DesignButton!
    @IBOutlet weak var buttonMenu: DesignButton!
    @IBOutlet weak var buttonTable: DesignButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomColor()
        localization()
        let backItem = UIBarButtonItem()
        backItem.title = Localizator.instance.localize(string: "Key_Back")
        navigationItem.backBarButtonItem = backItem
    }

    // set custom color
    func setCustomColor(){
        
    buttonTable.backgroundColor = UIColor.customLightBlue
    buttonMenu.backgroundColor = UIColor.customLightBlue
    buttonPrint.backgroundColor = UIColor.customLightBlue
        
    }
    func localization()
    {
        self.buttonTable.setTitle(Localizator.instance.localize(string: "Key_buttonTable"), for: .normal)
        self.buttonMenu.setTitle(Localizator.instance.localize(string: "Key_buttonMenu"), for: .normal)
        self.buttonPrint.setTitle(Localizator.instance.localize(string: "Key_buttonPrint"), for: .normal)
    }
    @IBAction func buttonTableAction(_ sender: Any) {
        
        let storyBord = UIStoryboard.init(name: "Main", bundle: nil)
        let orderItemVC = storyBord.instantiateViewController(withIdentifier: "AddFloorTableViewController") as! AddFloorTableViewController
        self.navigationController?.pushViewController(orderItemVC, animated: true)
        orderItemVC.title = Localizator.instance.localize(string: "Key_buttonTable")
    }
    
  
    @IBAction func buttonMenuAction(_ sender: Any) {
        
        let storyBord = UIStoryboard.init(name: "Main", bundle: nil)
        let MenuListVC = storyBord.instantiateViewController(withIdentifier: "MenuListViewController") as! MenuListViewController
        self.navigationController?.pushViewController(MenuListVC, animated: true)
        MenuListVC.title = Localizator.instance.localize(string: "Key_labelMenu")
        
    }
    
    @IBAction func buttonPrintAction(_ sender: Any) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
