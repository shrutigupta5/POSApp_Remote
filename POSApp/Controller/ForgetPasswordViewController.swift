//
//  ForgetPasswordViewController.swift
//  POSApp
//
//  Created by webwerks on 12/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var viewEmail: DesignableView!
    @IBOutlet weak var textFieldEmail: DesignableTextField!
    
    @IBOutlet weak var buttonSend: DesignButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomColor()
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.customLightBlue
         navigationController?.navigationBar.tintColor = UIColor.white
        textFieldEmail.delegate = self
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldEmail.resignFirstResponder()
        return true
    }
    func setCustomColor() {
        
        viewEmail.backgroundColor = UIColor.customLightBlue
         createAttributedPlacedholderToTextField(currentTextField: textFieldEmail, currentPlaceholderText: Localizator.instance.localize(string: "Key_email"))
        self.buttonSend.setTitle(Localizator.instance.localize(string: "Key_send"), for: .normal)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func actionSendButton(_ sender: Any) {
        let fetusers = DBManager.shared.fetchUsers(email: self.textFieldEmail.text!)
        
    if (self.textFieldEmail.text == ""){
                showDefaultAlertViewWith(alertTitle:"something went wrong", alertMessage: "Please Enter your email", okTitle: Localizator.instance.localize(string: "Key_ok"), currentViewController: self)
        }
        else if (fetusers[0].email != textFieldEmail.text ){
                showDefaultAlertViewWith(alertTitle: "New Password", alertMessage: "Please Enter your correct email", okTitle: Localizator.instance.localize(string: "Key_ok"), currentViewController: self)
        }
       else if (self.textFieldEmail.text == fetusers[0].email){
        showDefaultAlertViewWith(alertTitle: "New Password", alertMessage: fetusers[0].password, okTitle: Localizator.instance.localize(string: "Key_ok"), currentViewController: self)
    }
            else{
            showDefaultAlertViewWith(alertTitle:"something went wrong", alertMessage: "Please check your email", okTitle: Localizator.instance.localize(string: "Key_ok"), currentViewController: self)
        }
    }
    
    

}
