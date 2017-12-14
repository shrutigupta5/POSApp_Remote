//
//  ViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta on 17/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var forgotPasswordAction: UIButton!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var buttonSignIn: UIButton!
    
    var appDelegate = AppDelegate()
    var activeField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setCustomColor()
        setTextFieldDelegate()
        textFieldPlaceHolder()
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate

        // for keybord show and hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    // set custom color
    func setCustomColor() {
        
        viewEmail.backgroundColor = UIColor.customLightBlue
        viewPassword.backgroundColor = UIColor.customLightBlue
        buttonSignIn.backgroundColor = UIColor.customRed
    }
    
    // set textField place holder
    func textFieldPlaceHolder(){
        
        createAttributedPlacedholderToTextField(currentTextField: textFieldEmail, currentPlaceholderText: " Enter Email Address")
        createAttributedPlacedholderToTextField(currentTextField: textFieldPassword, currentPlaceholderText: "Enter Password")
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        textFieldEmail.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        return true
        
    }
    
    func setTextFieldDelegate(){
        
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        
    }
    
    func keyboardWillShow(notification:NSNotification){
        var info = notification.userInfo!
        let kbSize: CGSize = ((info[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size)
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        var aRect: CGRect = self.view.frame
        aRect.size.height -= kbSize.height
    }
    
    func keyboardWillHide(notification:NSNotification){
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    @IBAction func signInAction(_ sender: Any) {
        
    // fetching data base values and checking validation
    let fetchedUser = DBManager.shared.fetchUsers(email: self.textFieldEmail.text!)
        
        
        
        if fetchedUser.count  > 0 {
            let userInfoDict:[String:String] = ["email":fetchedUser[0].email,"firstName":fetchedUser[0].firstName,"lastName":fetchedUser[0].lastName,"password":fetchedUser[0].password]
            UserDefaults.standard.set(userInfoDict, forKey: "userInfoDict")
            let result = UserDefaults.standard.value(forKey: "userInfoDict")
            print(result!)
            
            print("Data is = \(fetchedUser)")
            if (self.textFieldEmail.text == fetchedUser[0].email) && (self.textFieldPassword.text == fetchedUser[0].password) {
                let storyB = UIStoryboard.init(name: "Main", bundle: nil)
                let  navVC = storyB.instantiateViewController(withIdentifier: "NavVc") as! UINavigationController
               self.appDelegate.window?.rootViewController = navVC
                
            }
            
        }
            
        else if(self.textFieldEmail.text == "") && (self.textFieldPassword.text == "") {
        showDefaultAlertViewWith(alertTitle: "Error Msg", alertMessage: "please Enter Email and Password", okTitle: "ok", currentViewController: self)
        }
            
        else if(self.textFieldEmail.text == "") {
            showDefaultAlertViewWith(alertTitle: "Error Msg", alertMessage: "please Enter Email ", okTitle: "ok", currentViewController: self)
        }
            
        else if(self.textFieldPassword.text == ""){
            showDefaultAlertViewWith(alertTitle: "Error Msg", alertMessage: "please Enter Password ", okTitle: "ok", currentViewController: self)
        }
            
      else{
        showDefaultAlertViewWith(alertTitle: "Error", alertMessage: "Please Enter Email and Password", okTitle: "ok", currentViewController: self)
        }
        
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let forgetVC = storyboard.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as! ForgetPasswordViewController
        self.navigationController?.pushViewController(forgetVC,animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

