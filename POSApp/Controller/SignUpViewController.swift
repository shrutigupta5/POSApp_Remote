//
//  SignUpViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta on 17/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.


import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var buttonSignUp: UIButton!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewFirstName: UIView!
    @IBOutlet weak var viewLastName: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var appDelegate = AppDelegate()
    var sceneType : SceneType? = nil
    var users: [UserInfo]!
    var dataBase : FMDatabase = FMDatabase()
    var dataArray: [AnyObject] = []
    var firstName = ""
    var lastName  = ""
    var email     = ""
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setTextFieldDelegate()
        textFieldPlaceHolder()
        setCustomColor()
        
        switch sceneType {
        case .InitialScene?:
            self.buttonSignUp.setTitle("Sign Up", for: .normal)
            break
        case .SideMenuScene?:

            self.textFieldEmail.text = email
            self.textFieldFirstName.text = firstName
            self.textFieldLastName.text = lastName
            textFieldEmail.isUserInteractionEnabled = false
            self.buttonSignUp.setTitle("Update", for: .normal)
            self.viewPassword.isHidden = true
            break
        default : break
        }
        
        let dataSharedInstance = DBManager.shared
        dataSharedInstance.fetchTextFieldValue(withFirstName: textFieldFirstName.text!, withLastName: textFieldLastName.text!, withEmail: textFieldEmail.text!, withPassword: textFieldPassword.text!)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        // Do any additional setup after loading the view.
        
        
    }
    
    func setCustomColor(){
        
        buttonSignUp.backgroundColor = UIColor.customRed
        viewFirstName.backgroundColor = UIColor.customLightBlue
        viewLastName.backgroundColor = UIColor.customLightBlue
        viewEmail.backgroundColor  = UIColor.customLightBlue
        viewPassword.backgroundColor = UIColor.customLightBlue
        
    }
    
    func textFieldPlaceHolder(){
        
        createAttributedPlacedholderToTextField(currentTextField: textFieldFirstName, currentPlaceholderText: "Enter First Name")
        createAttributedPlacedholderToTextField(currentTextField: textFieldLastName, currentPlaceholderText: "Enter Last Name")
        createAttributedPlacedholderToTextField(currentTextField: textFieldEmail, currentPlaceholderText: "Enter Email Address")
        createAttributedPlacedholderToTextField(currentTextField: textFieldPassword, currentPlaceholderText: "Enter Password")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textFieldFirstName.resignFirstResponder()
        textFieldLastName.resignFirstResponder()
        textFieldEmail.resignFirstResponder()
        textFieldPassword.resignFirstResponder()
        return true
        
    }
    
    func setTextFieldDelegate(){
        
        textFieldFirstName.delegate = self
        textFieldLastName.delegate = self
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
        
    }
    
    func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
        
    }
    
    func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        scrollView.contentInset = contentInset
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
        
    }
    
    func isValidPincode(value: String) -> Bool {
        
        var status : Bool = true
        
        if value.count < 6 {
            status = false
        }
        return status
    }
    
    
    @IBAction func signUpButtonAction(_ sender: Any) {
     
     switch sceneType {
        case .InitialScene?:
           checkFieldsValidation()
            break
        case .SideMenuScene?:
            DBManager.shared.updateUserInfo(firstName: self.textFieldFirstName.text!, lastName: self.textFieldLastName.text!, email:self.textFieldEmail.text!)
            let fetchUserUpdaetInfo = DBManager.shared.fetchUsers(email: self.textFieldEmail.text!)
            let userInfoDict:[String:String] = ["email":fetchUserUpdaetInfo[0].email,"firstName":fetchUserUpdaetInfo[0].firstName,"lastName":fetchUserUpdaetInfo[0].lastName]
            UserDefaults.standard.set(userInfoDict, forKey: "userInfoDict")
            let result = UserDefaults.standard.value(forKey: "userInfoDict")
            print(result!)
            break
        default : break
        }
       
        
        
        
    }
    
    func checkFieldsValidation(){
        let emailResult = isValidEmail(testStr: textFieldEmail.text!)
        let passwordResult = isValidPincode(value:textFieldPassword.text!)
        if ((emailResult&&passwordResult == true) && ((textFieldFirstName.text != "") && (textFieldLastName.text != ""))){
            DBManager.shared.insertIntoPosUser(fname: self.textFieldFirstName.text!, lname: self.textFieldLastName.text!, email: self.textFieldEmail.text!, pwd: self.textFieldPassword.text!)
            let alertController = UIAlertController(title: "save", message: "Data Inserted Successfully", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                alert -> Void in
                let storyB = UIStoryboard.init(name: "Main", bundle: nil)
                let  navVC = storyB.instantiateViewController(withIdentifier: "NavVc") as! UINavigationController
                self.appDelegate.window?.rootViewController = navVC
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if ((self.textFieldEmail.text == "") && (self.textFieldPassword.text == "") && (textFieldFirstName.text  == "") && (textFieldLastName.text == "")) {
            showDefaultAlertViewWith(alertTitle: "empty ", alertMessage: "Please enter all field", okTitle: "discard", currentViewController: self)
        }
        else if ((self.textFieldPassword.text == "") && (self.textFieldFirstName.text != "") && (self.textFieldLastName.text != "") && (self.textFieldEmail.text != "")) {
            
            showDefaultAlertViewWith(alertTitle: "empty", alertMessage: "Please Enter Password", okTitle: "discard", currentViewController: self)
        }
        else if (textFieldFirstName.text  == "")  {
            
            showDefaultAlertViewWith(alertTitle: "Error", alertMessage: "please enter first name", okTitle: "ok", currentViewController: self)
        }
        else if (textFieldLastName.text  == "") {
            
            showDefaultAlertViewWith(alertTitle: "Error", alertMessage: "please enter last name", okTitle: "ok", currentViewController: self)
        }
            
        else if(self.textFieldEmail.text == "") {
            
            showDefaultAlertViewWith(alertTitle: "empty", alertMessage: "Please enter Email Address", okTitle: "dismiss", currentViewController: self)
        }
        else {
            
            showDefaultAlertViewWith(alertTitle: "empty", alertMessage: "Please enter correct email & password", okTitle: "discard", currentViewController: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
