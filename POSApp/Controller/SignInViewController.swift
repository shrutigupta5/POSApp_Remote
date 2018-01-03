//
//  ViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta on 17/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import TwitterKit
import Google
import GoogleSignIn
import LinkedinSwift


class SignInViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate, GIDSignInDelegate {
   //MARK:- Variable declaration
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var buttonSignIn: UIButton!
    @IBOutlet weak var buttonForgetPassword: UIButton!
    @IBOutlet weak var buttonLinkedIn: DesignButton!
    
    var appDelegate = AppDelegate()
    var activeField: UITextField!
    let reachability = Reachability()!
    var dict : [String : AnyObject]!
    
    let linkedinHelper = LinkedinSwiftHelper(configuration: LinkedinSwiftConfiguration(clientId: "81wgc9yigszxeo", clientSecret: "8fcAMmANRsNkdYmB", state: "DCEEFWF45453sdffef424", permissions: ["r_basicprofile", "r_emailaddress"], redirectUrl: "https://com.POSApp.linkedin.oauth/oauth"))
   
    //MARK:- View life cycle methods
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
        twiterLogin()
        gmailLogin()
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        GIDSignIn.sharedInstance().signOut()
    }
   //MARK:- Helper methods
   

    func gmailLogin()
    {
        var error : NSError?
        
        //setting the error
        GGLContext.sharedInstance().configureWithError(&error)
        
        //if any error stop execution and print error
        if error != nil{
            print(error ?? "google error")
            return
        }
        
        
        //adding the delegates
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        //getting the signin button and adding it to view
        let googleSignInButton = GIDSignInButton()
//        let newFrame = CGPoint(x: 650, y:660)
//        googleSignInButton.center = newFrame
        view.addSubview(googleSignInButton)
        let verticalConstraint = NSLayoutConstraint(item: googleSignInButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: buttonLinkedIn, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 150)
        
        let heightConstraint = NSLayoutConstraint(item: googleSignInButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 54)
        
        let topLeftViewLeadingConstraint = NSLayoutConstraint(item: googleSignInButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal
            , toItem: buttonLinkedIn, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        
        
        let topRightViewTrailingConstraint = NSLayoutConstraint(item: googleSignInButton, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal
            , toItem: buttonLinkedIn, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        
        
        googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([ verticalConstraint, heightConstraint,topLeftViewLeadingConstraint,topRightViewTrailingConstraint])
        
        
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        //if any error stop and print the error
        if error != nil{
            print(error ?? "google error")
            return
        }
        
        //if success display the email on label
        let email = user.profile.email
        let firstname = user.profile.givenName
        let lastname = user.profile.familyName
        print("email is \(String(describing: email))")
        let userInfoDict:[String:String] = ["email":email!,"firstName":firstname!,"lastName":lastname! ]
        UserDefaults.standard.set(userInfoDict, forKey: "userInfoDict")
        let result = UserDefaults.standard.value(forKey: "userInfoDict")
        print(result!)
        let storyB = UIStoryboard.init(name: "Main", bundle: nil)
        let  navVC = storyB.instantiateViewController(withIdentifier: "NavVc") as! UINavigationController
        self.appDelegate.window?.rootViewController = navVC
    }
    
    func facebookLoad() {
        let loginButton = FBSDKLoginButton.init()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"];
//        let newFrame = CGPoint(x: 650, y:550)
//       loginButton.center = newFrame
        loginButton.delegate = self
        view.addSubview(loginButton)
        
        let verticalConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: buttonLinkedIn, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 20)
        
        let heightConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 54)
        
        let topLeftViewLeadingConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal
            , toItem: buttonLinkedIn, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        
        
        let topRightViewTrailingConstraint = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal
            , toItem: buttonLinkedIn, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        
        
         loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([ verticalConstraint, heightConstraint,topLeftViewLeadingConstraint,topRightViewTrailingConstraint])
        
    }
    
    func twiterLogin()
    {
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                print("signed in as \(String(describing: session?.userName))")
                let client = TWTRAPIClient.withCurrentUser()
                let request = client.urlRequest(withMethod: "GET",
                                                urlString: "https://api.twitter.com/1.1/account/verify_credentials.json?include_email=true",
                                                parameters: ["include_email": "true", "skip_status": "true"],
                                                error: nil)
                client.sendTwitterRequest(request) { response, data, connectionError in
                    if (connectionError == nil) {
                        
                        do{
                            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                            print("Json response: ", json)
                            let firstName = json["name"]
                            let lastName = json["screen_name"]
                            let email = json["email"]
                            print("First name: ",firstName ?? "")
                            print("Last name: ",lastName ?? "")
                            print("Email: ",email ?? "")
                            let userInfoDict:[String:String] = ["email":email as! String,"firstName":firstName as! String,"lastName":"" ]
                            UserDefaults.standard.set(userInfoDict, forKey: "userInfoDict")
                            let result = UserDefaults.standard.value(forKey: "userInfoDict")
                            print(result!)
                            let storyB = UIStoryboard.init(name: "Main", bundle: nil)
                            let  navVC = storyB.instantiateViewController(withIdentifier: "NavVc") as! UINavigationController
                            self.appDelegate.window?.rootViewController = navVC
                        } catch {
                            
                        }
                    }
                    else {
                        print("Error: \(String(describing: connectionError))")
                    }
                    }
            } else {
                print("error: \(String(describing: error?.localizedDescription))")
            }
        })
        view.addSubview(logInButton)
        let verticalConstraint = NSLayoutConstraint(item: logInButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: buttonLinkedIn, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 90)
        
        let heightConstraint = NSLayoutConstraint(item: logInButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 54)
        
        let topLeftViewLeadingConstraint = NSLayoutConstraint(item: logInButton, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal
            , toItem: buttonLinkedIn, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        
        
        let topRightViewTrailingConstraint = NSLayoutConstraint(item: logInButton, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal
            , toItem: buttonLinkedIn, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        
        
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([ verticalConstraint, heightConstraint,topLeftViewLeadingConstraint,topRightViewTrailingConstraint])
    }
    
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        
        loginManager.logIn(readPermissions: [.publicProfile], viewController: self) { (loginResult) in
   
        }

    }
    func localization()
    {
      
        self.buttonSignIn.setTitle(Localizator.instance.localize(string: "Key_signIn"), for: .normal)
        self.buttonForgetPassword.setTitle(Localizator.instance.localize(string: "Key_forgetPassword"), for: .normal)
    }
    
    //MARK:- set custom color
    func setCustomColor() {
        
        viewEmail.backgroundColor = UIColor.customLightBlue
        viewPassword.backgroundColor = UIColor.customLightBlue
        buttonSignIn.backgroundColor = UIColor.customRed
    }
    
    //MARK:- set textField place holder
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
        
        //Mark:- fetching data base values and checking validation
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
   
    @IBAction func actionLinkedInButton(_ sender: Any) {
//        let url  = NSURL(string: "linkedin://");
//        UIApplication.shared.openURL(url! as URL)
        linkedinHelper.authorizeSuccess({ (lsToken) -> Void in
            //Login success lsToken
        }, error: { (error) -> Void in
            //Encounter error: error.localizedDescription
        }, cancel: { () -> Void in
            //User Cancelled!
        })
    }
    
    
    
}
extension SignInViewController:FBSDKLoginButtonDelegate
{
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {

        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name,email, picture.type(large)"]).start { (connection, result, error) -> Void in

            if let responseResult = result as? NSDictionary {
                
                if let strEmail = responseResult.object(forKey: "email") as? String {
                    let strFirstName = responseResult.object(forKey: "first_name") as! String
                    let strLastName = responseResult.object(forKey: "last_name") as! String
                    print(strEmail)
                    
                    print(strFirstName)
                    if responseResult.count  > 0 {
                        
                        let userInfoDict:[String:String] = ["email":strEmail,"firstName":strFirstName,"lastName":strLastName]
                        UserDefaults.standard.set(userInfoDict, forKey: "userInfoDict")
                        let result = UserDefaults.standard.value(forKey: "userInfoDict")
                        print(result!)
                        
                            let storyB = UIStoryboard.init(name: "Main", bundle: nil)
                            let  navVC = storyB.instantiateViewController(withIdentifier: "NavVc") as! UINavigationController
                            self.appDelegate.window?.rootViewController = navVC
                            
                        }
                        
                    }
                    
                }
                else{
                    showDefaultAlertViewWith(alertTitle: "Error", alertMessage: "Please enter email address", okTitle: "ok", currentViewController: self)
                }

            }

        }
        
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
}

