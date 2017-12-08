//
//  SideMenuViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta on 23/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableViewSideMenu: UITableView!
    var menuDictArray : [[String : String]] = [[:]]
   
//    var menuArray: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
           self.navigationController?.navigationBar.barTintColor = UIColor(red:(31/255.0), green:(31/255.0), blue:(31/255.0), alpha:1.0)
        setupView()
        loadData()
        // Do any additional setup after loading the view.
    }
    func setupView() {
        
        self.tableViewSideMenu.delegate = self
        self.tableViewSideMenu.dataSource = self
        self.tableViewSideMenu.register(UINib(nibName:"SideMenuTableViewCell", bundle:nil), forCellReuseIdentifier: "SideMenuTableViewCell")
        self.tableViewSideMenu.register(UINib(nibName:"ProfileTableViewCell", bundle:nil), forCellReuseIdentifier: "ProfileTableViewCell")
    }
    
    func loadData(){
        
           menuDictArray = [["name" : "","imageName" : "", "category" : "-1"], ["name" : "Home", "imageName" : "homeImage","category" : "-1"], ["name" : "Orders", "imageName" : "order1Image", "category" : "1"], ["name" : "End Of Day", "imageName" : "eod1", "category" : "3"],["name" : "Management", "imageName" : "managementImage", "category" : "2"], ["name" : "Configuration", "imageName" : "configuration", "category" : "-1"], ["name" : "Customer", "imageName" : "customerImg1", "category" : "-1"], ["name" : "Logout", "imageName" : "logoutImage", "category" : "-1"]]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuDictArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0){
            let profileCell = self.tableViewSideMenu.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath)as! ProfileTableViewCell
            return profileCell
        }
        else{
            let userCell = self.tableViewSideMenu.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath)as! SideMenuTableViewCell
            userCell.labelMenuName.text = menuDictArray[indexPath.row]["name"]
            userCell.imageViewMenuItem.image = UIImage(named: menuDictArray[indexPath.row]["imageName"]!)
            return userCell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBord = UIStoryboard.init(name: "Main", bundle: nil)
        let nameFetch = menuDictArray[indexPath.row]["name"]
        if(nameFetch == "Orders"){
            let OrderVC = storyBord.instantiateViewController(withIdentifier: "OrdersViewController") as! OrdersViewController
                        self.navigationController?.pushViewController(OrderVC, animated: true)
                        OrderVC.title = "order"
        }
        else if(nameFetch == "Home"){
            let homeVC = storyBord.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeVC, animated: true)
           
        }
        else if(nameFetch == "End Of Day"){
            let eodVC = storyBord.instantiateViewController(withIdentifier: "EndOfDayViewController") as! EndOfDayViewController
            self.navigationController?.pushViewController(eodVC, animated: true)
            eodVC.title = "End Of Day"
            
        }
        else if(nameFetch == "Management"){
            
            let mgntVC = storyBord.instantiateViewController(withIdentifier: "ManagementViewController") as! ManagementViewController
            self.navigationController?.pushViewController(mgntVC, animated: true)
            mgntVC.title = "Management"
        }
        else if(nameFetch == "Configuration"){
            
            let configVC = storyBord.instantiateViewController(withIdentifier: "ConfigurationViewController") as! ConfigurationViewController
            self.navigationController?.pushViewController(configVC, animated: true)
            configVC.title = "Configuration"
        }
        else if(nameFetch == "Customer"){
            
            let customerVC = storyBord.instantiateViewController(withIdentifier: "CustomerViewController") as! CustomerViewController
            self.navigationController?.pushViewController(customerVC, animated: true)
            customerVC.title = "Customer"
        }
        else if(nameFetch == "Logout"){

    let refreshAlert = UIAlertController(title: "LogOut", message: "Are You Sure to Log Out ? ", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (action: UIAlertAction!) in
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BaseViewController")
                self.present(viewController, animated: true, completion: nil)
            
                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Nevermind", style: .default, handler: { (action: UIAlertAction!) in
                refreshAlert .dismiss(animated: true, completion: nil)
                }))
            
            present(refreshAlert, animated: true, completion: nil)
            }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0){
            return 300
        }
        else
        {
           return 100
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
