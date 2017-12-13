//
//  ForgetPasswordViewController.swift
//  POSApp
//
//  Created by webwerks on 12/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var viewEmail: DesignableView!
    @IBOutlet weak var textFieldEmail: DesignableTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomColor()
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.customLightBlue
         navigationController?.navigationBar.tintColor = UIColor.white
        
        
    }
    
    func setCustomColor() {
        
        viewEmail.backgroundColor = UIColor.customLightBlue
         createAttributedPlacedholderToTextField(currentTextField: textFieldEmail, currentPlaceholderText: " Enter Email Address")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionSendButton(_ sender: Any) {
        let fetusers = DBManager.shared.fetchUsers(email: self.textFieldEmail.text!)
        if (self.textFieldEmail.text != ""){
            showDefaultAlertViewWith(alertTitle: "New Password", alertMessage: fetusers[0].password, okTitle: "ok", currentViewController: self)
        }
        else{
            showDefaultAlertViewWith(alertTitle:"something went wrong", alertMessage: "Please check your email", okTitle: "ok", currentViewController: self)
        }
        
    }
    
    

}
