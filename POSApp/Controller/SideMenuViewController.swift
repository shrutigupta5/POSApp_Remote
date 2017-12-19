//
//  SideMenuViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta on 23/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    var appDelegate = AppDelegate()
    
    @IBOutlet weak var tableViewSideMenu: UITableView!
    var menuDictArray : [[String : String]] = [[:]]
    var userDefaultsDictionary  : [String:String] = [:]
    var userFirstName = ""
    var userLastName = ""
    var userEmail = ""
    override func viewDidLoad() {
        super.viewDidLoad()
           self.navigationController?.navigationBar.barTintColor = UIColor(red:(31/255.0), green:(31/255.0), blue:(31/255.0), alpha:1.0)
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userDefaults = UserDefaults.standard
        self.userDefaultsDictionary = userDefaults.value(forKey: "userInfoDict") as! [String:String]
        
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
        
           menuDictArray = [["name" : "profile","imageName" : "", "category" : "-1"], ["name" : "Home", "imageName" : "homeImage","category" : "-1"], ["name" : "Orders", "imageName" : "order1Image", "category" : "1"], ["name" : "End Of Day", "imageName" : "eod_iconImg", "category" : "3"],["name" : "Management", "imageName" : "managemnt_icon", "category" : "2"], ["name" : "Configuration", "imageName" : "configure_icon", "category" : "-1"], ["name" : "Customer", "imageName" : "user_icon", "category" : "-1"], ["name" : "Logout", "imageName" : "logoutImage", "category" : "-1"]]
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
            profileCell.labelFirstName.text = self.userDefaultsDictionary["firstName"]!+"  "+self.userDefaultsDictionary["lastName"]!
           
            profileCell.labelEmailAddress.text = self.userDefaultsDictionary["email"]
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
        else if(nameFetch == "profile"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            let scene = SceneType.SideMenuScene
            signUpVC.sceneType = scene
            signUpVC.firstName = self.userDefaultsDictionary["firstName"]!
            signUpVC.lastName = self.userDefaultsDictionary["lastName"]!
            signUpVC.email = self.userDefaultsDictionary["email"]!
            self.navigationController?.pushViewController(signUpVC,animated: true)
            
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

          //mark:custom alert
            let alert = UIAlertController(title: "LogOut",
                                          message: "Are You Sure to Log Out ?",
                                          preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "LogOut", style: .default, handler: { (action) -> Void in
                self.dismiss(animated: true, completion: {
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")
                        let  navVC = self.storyboard?.instantiateViewController(withIdentifier: "InitialNavVC") as! UINavigationController
                    UserDefaults.standard.removeObject(forKey: "userInfoDict")
                navVC.setViewControllers([viewController], animated: false)
                self.appDelegate.window?.rootViewController = navVC
                self.dismissModalStack()
        })
    })
            let cancel = UIAlertAction(title: "Nevermind", style: .destructive, handler: { (action) -> Void in })
            alert.view.tintColor = UIColor.blue
            alert.addAction(submitAction)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)

            
        }
    }
    
    func dismissModalStack() {
        
        var vc: UIViewController? = self.presentedViewController
        while ((vc?.presentedViewController) != nil) {
            vc = vc?.presentingViewController
        }
        vc?.dismiss(animated: true, completion: { _ in })
        
        var svc: UIViewController? = SideMenuManager.menuLeftNavigationController?.presentingViewController
        
        while ((svc?.presentedViewController) != nil) {
            svc = svc?.presentingViewController
        }
        svc?.dismiss(animated: true, completion: { _ in })
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
