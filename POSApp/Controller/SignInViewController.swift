//
//  ViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta on 17/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin


class SignInViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var buttonSignIn: UIButton!
    @IBOutlet weak var buttonForgetPassword: UIButton!
    
    var appDelegate = AppDelegate()
    var activeField: UITextField!
    let reachability = Reachability()!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setCustomColor()
        setTextFieldDelegate()
        textFieldPlaceHolder()
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        localization()
        // for keybord show and hide
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        facebookLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    func facebookLoad() {
//        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
//        loginButton.center = view.center
//        view.addSubview(loginButton)
        
    let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.blue
        myLoginButton.frame = CGRect(x: 100, y: 100, width: 180, height: 80)
        myLoginButton.center = view.center
        myLoginButton.setTitle("Facebook Login ", for: .normal)

        myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)

        // Add the button to the view
        view.addSubview(myLoginButton)
    }
//    // Once the button is clicked, show the login dialog
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()

//        loginManager.logIn(publishPermissions: [PublishPermission.publishActions], viewController: self) { (loginResult) in
//            print("login result is:-\(loginResult)")
//
//        }
        
        loginManager.logIn(readPermissions: [ReadPermission.publicProfile,ReadPermission.email], viewController: self) { (loginResult) in
            
//            switch loginResult {
//            case .failed(let error):
//                print(error)
//            case .cancelled:
//                print("User cancelled login.")
//            case .Success(let grantedPermissions, let declinedPermissions, let accessToken):
//                print("Logged in!")
//            }
        }
        
    }
    func localization()
    {
      
        self.buttonSignIn.setTitle(Localizator.instance.localize(string: "Key_signIn"), for: .normal)
        self.buttonForgetPassword.setTitle(Localizator.instance.localize(string: "Key_forgetPassword"), for: .normal)
    }
    
    // set custom color
    func setCustomColor() {
        
        viewEmail.backgroundColor = UIColor.customLightBlue
        viewPassword.backgroundColor = UIColor.customLightBlue
        buttonSignIn.backgroundColor = UIColor.customRed
    }
    
    // set textField place holder
    func textFieldPlaceHolder(){
        
        createAttributedPlacedholderToTextField(currentTextField: textFieldEmail, currentPlaceholderText: Localizator.instance.localize(string: "Key_email"))
        createAttributedPlacedholderToTextField(currentTextField: textFieldPassword, currentPlaceholderText: Localizator.instance.localize(string: "Key_password"))
        
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
    func internetChanged(note: Notification){
        let reachability = note.object as! Reachability
        if reachability.connection != .none{
            if reachability.connection == .wifi{
                DispatchQueue.main.async {
                    //self.callToGetWebServices()
                }
            }
            else{
                DispatchQueue.main.async {
                    showDefaultAlertViewWith(alertTitle:Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage: "please turn on intternet connection", okTitle: Localizator.instance.localize(string: "Key_ok"), currentViewController: self)
                }
            }
        }
        else{
            DispatchQueue.main.async {
                showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage: "something went wrong", okTitle: Localizator.instance.localize(string: "Key_ok"), currentViewController: self)
            }
        }
    }
    @IBAction func signInAction(_ sender: Any) {
        reachability.whenReachable = { _ in
            DispatchQueue.main.async {
               // self.callToGetWebServices()
            }
        }
        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async {
                showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage: "please turn on intternet connection", okTitle: Localizator.instance.localize(string: "Key_ok"), currentViewController: self)
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }
        catch{
            print("could not start notifire")
        }
        
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
        showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage: Localizator.instance.localize(string: "Key_AlertMsg"), okTitle: Localizator.instance.localize(string: "Key_ok"), currentViewController: self)
        }
            
        else if(self.textFieldEmail.text == "") {
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage: Localizator.instance.localize(string: "Key_emailAlert"), okTitle: Localizator.instance.localize(string: "Key_ok"), currentViewController: self)
        }
            
        else if(self.textFieldPassword.text == ""){
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage: Localizator.instance.localize(string: "key_AlertPassword"), okTitle: Localizator.instance.localize(string: "Key_ok"), currentViewController: self)
        }
            
      else{
        showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage: Localizator.instance.localize(string: "Key_emailAlert"), okTitle: Localizator.instance.localize(string: "Key_ok"), currentViewController: self)
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

