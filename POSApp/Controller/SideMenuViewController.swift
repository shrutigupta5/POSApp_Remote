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
        
           menuDictArray = [["name" : Localizator.instance.localize(string: "Key_profile"),"imageName" : "", "category" : "-1"], ["name" : Localizator.instance.localize(string: "Key_home"), "imageName" : "homeImage","category" : "-1"], ["name" : Localizator.instance.localize(string: "Key_Order"), "imageName" : "order1Image", "category" : "1"], ["name" : Localizator.instance.localize(string: "Key_eod"), "imageName" : "eod_iconImg", "category" : "3"],["name" : Localizator.instance.localize(string: "Key_managementButton"), "imageName" : "managemnt_icon", "category" : "2"], ["name" : Localizator.instance.localize(string: "Key_Configuration"), "imageName" : "configure_icon", "category" : "-1"], ["name" : Localizator.instance.localize(string: "Key_Customer"), "imageName" : "user_icon", "category" : "-1"], ["name" : Localizator.instance.localize(string: "Key_logout"), "imageName" : "logoutImage", "category" : "-1"]]
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
//            self.labelFirstName.text = Localizator.instance.localize(string: "key_user")
//            self.labelEmailAddress.text = Localizator.instance.localize(string: "Key_email")
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
        if(nameFetch == Localizator.instance.localize(string: "Key_Order")){
            let OrderVC = storyBord.instantiateViewController(withIdentifier: "OrdersViewController") as! OrdersViewController
                        self.navigationController?.pushViewController(OrderVC, animated: true)
                        OrderVC.title = Localizator.instance.localize(string: "Key_Order")
        }
            
        else if(nameFetch == Localizator.instance.localize(string: "Key_profile")){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            let scene = SceneType.SideMenuScene
            signUpVC.sceneType = scene
            signUpVC.firstName = self.userDefaultsDictionary["firstName"]!
            signUpVC.lastName = self.userDefaultsDictionary["lastName"]!
            signUpVC.email = self.userDefaultsDictionary["email"]!
            self.navigationController?.pushViewController(signUpVC,animated: true)
            
        }
        else if(nameFetch == Localizator.instance.localize(string: "Key_home")){
            let homeVC = storyBord.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeVC, animated: true)
         homeVC.title  = Localizator.instance.localize(string: "Key_home")
        }
        else if(nameFetch == Localizator.instance.localize(string: "Key_eod")){
            let eodVC = storyBord.instantiateViewController(withIdentifier: "EndOfDayViewController") as! EndOfDayViewController
            self.navigationController?.pushViewController(eodVC, animated: true)
            eodVC.title = Localizator.instance.localize(string: "Key_eod")
            
        }
        else if(nameFetch == Localizator.instance.localize(string: "Key_managementButton")){
            
            let mgntVC = storyBord.instantiateViewController(withIdentifier: "ManagementViewController") as! ManagementViewController
            self.navigationController?.pushViewController(mgntVC, animated: true)
            mgntVC.title = Localizator.instance.localize(string: "Key_managementButton")
        }
        else if(nameFetch == Localizator.instance.localize(string: "Key_Configuration")){
            
            let configVC = storyBord.instantiateViewController(withIdentifier: "ConfigurationViewController") as! ConfigurationViewController
            self.navigationController?.pushViewController(configVC, animated: true)
            configVC.title = Localizator.instance.localize(string: "Key_Configuration")
        }
        else if(nameFetch == Localizator.instance.localize(string: "Key_Customer")){
            
            let customerVC = storyBord.instantiateViewController(withIdentifier: "CustomerViewController") as! CustomerViewController
            self.navigationController?.pushViewController(customerVC, animated: true)
            customerVC.title = Localizator.instance.localize(string: "Key_Customer")
        }
        else if(nameFetch == Localizator.instance.localize(string: "Key_logout")){

          //mark:custom alert
            let alert = UIAlertController(title: Localizator.instance.localize(string: "Key_logout"),
                                          message: Localizator.instance.localize(string: "Key_LogoutMsg"),
                                          preferredStyle: .alert)
            let submitAction = UIAlertAction(title: Localizator.instance.localize(string: "Key_logout"), style: .destructive, handler: { (action) -> Void in
                self.dismiss(animated: true, completion: {
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController")
                        let  navVC = self.storyboard?.instantiateViewController(withIdentifier: "InitialNavVC") as! UINavigationController
                    UserDefaults.standard.removeObject(forKey: "userInfoDict")
                navVC.setViewControllers([viewController], animated: false)
                self.appDelegate.window?.rootViewController = navVC
                self.dismissModalStack()
        })
    })
            
            let cancel = UIAlertAction(title: Localizator.instance.localize(string: "Key_Nevermind"), style: .default, handler: { (action) -> Void in })
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
