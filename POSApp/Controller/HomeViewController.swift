//
//  HomeViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta on 23/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
    
    @IBOutlet weak var buttonCustomer: DesignButton!
    @IBOutlet weak var buttonConfigration: DesignButton!
    @IBOutlet weak var buttonManagement: DesignButton!
    @IBOutlet weak var buttonEndOfDay: DesignButton!
    @IBOutlet weak var buttonOrders: DesignButton!
    @IBOutlet weak var buttonSideMenu: UIButton!
    
    var fetchEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designNavigation()
        setCustomColor()
    }
    
    func setCustomColor(){
        
        buttonOrders.backgroundColor = UIColor.customLightBlue
        buttonEndOfDay.backgroundColor = UIColor.customLightBlue
        buttonManagement.backgroundColor = UIColor.customLightBlue
        buttonCustomer.backgroundColor = UIColor.customLightBlue
        buttonConfigration.backgroundColor = UIColor.customLightBlue
        
    }
    
    func designNavigation(){
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "menuIcon"), style: .plain, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItem  = menuButton
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        applyAttributedNavigationBarTitleWith(currentTitle: "Home", currentNavigationController: self.navigationController!)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 34)!, NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.brown
        self.navigationController?.view.tintColor = UIColor.white
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
}
    
    @IBAction func buttonConfigurationAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let configVC = storyBoard.instantiateViewController(withIdentifier: "ConfigurationViewController") as! ConfigurationViewController
        self.navigationController?.pushViewController(configVC, animated: true)
        configVC.title = "Configuration"
        
    }
    
    @IBAction func buttonCustomerAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let customerVC = storyBoard.instantiateViewController(withIdentifier: "CustomerViewController") as! CustomerViewController
        navigationController?.pushViewController(customerVC, animated: true)
        customerVC.title = "Customer"
        
    }
    
    @IBAction func buttonManagementAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let mgntVC = storyBoard.instantiateViewController(withIdentifier: "ManagementViewController") as! ManagementViewController
        navigationController?.pushViewController(mgntVC, animated: true)
        mgntVC.title = "Management"
        
    }
    
    @IBAction func buttonEndOfDayAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let eodVC = storyBoard.instantiateViewController(withIdentifier: "EndOfDayViewController") as! EndOfDayViewController
        navigationController?.pushViewController(eodVC, animated: true)
        eodVC.title = "End Of Day"
        
    }
  
    @IBAction func buttonOrderAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let  orderVC = storyBoard.instantiateViewController(withIdentifier: "OrdersViewController") as! OrdersViewController
        self.navigationController?.pushViewController(orderVC, animated: true)
        orderVC.title = "Order"
        
    }
    
    func addTapped (sender:UIButton) {
        print("add pressed")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UISideMenuNavigationController") as! UISideMenuNavigationController
        
        self.present(vc, animated: true, completion: nil)
        
    }
   
}
