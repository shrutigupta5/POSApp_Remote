//
//  AddNewEmployeePopUpViewController.swift
//  POSApp
//
//  Created by Shruti Gupta on 19/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class AddNewEmployeePopUpViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var viewPopup: UIView!
    @IBOutlet weak var viewName: DesignableView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var viewPassword: DesignableView!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var viewRole: DesignableView!
    @IBOutlet weak var textFieldRole: UITextField!
    @IBOutlet weak var viewContact: DesignableView!
    @IBOutlet weak var textFieldContact: UITextField!
    @IBOutlet weak var viewAddress: DesignableView!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var viewRate: DesignableView!
    @IBOutlet weak var textFieldRate: UITextField!
    @IBOutlet weak var viewHourly: DesignableView!
    @IBOutlet weak var textFieldHourly: UITextField!
    @IBOutlet weak var buttonSave: DesignButton!
    @IBOutlet weak var buttonClose: DesignButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    weak var delegate: AddNewEmployeePopUpViewControllerDelegate?
    var sceneType : SceneType? = nil
    var activeField: UITextField!
    var employeeInfoArray :[String] = []
    var userDefaultsDictionary  : [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        if let userDefaultsDictionary = userDefaults.value(forKey: "employeeInfoDict") as? [String:String]{
            self.userDefaultsDictionary = userDefaults.value(forKey: "employeeInfoDict") as! [String:String]
        }
       
        textFieldDelegate()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        switch sceneType {
        case .addEmployeeListScene?:
            self.buttonSave.setTitle( Localizator.instance.localize(string: "Key_save"), for: .normal)
            self.buttonClose.setTitle( Localizator.instance.localize(string: "Key_buttonClose"), for: .normal)
            break
        case .addEmployeeScene?:
            self.textFieldName.text = userDefaultsDictionary["name"]
             self.textFieldPassword.text = userDefaultsDictionary["password"]
             self.textFieldRole.text = userDefaultsDictionary["role"]
             self.textFieldContact.text = userDefaultsDictionary["contact"]
             self.textFieldAddress.text = userDefaultsDictionary["address"]
             self.textFieldRate.text = userDefaultsDictionary["rate"]
             self.textFieldHourly.text = userDefaultsDictionary["hourly"]
            textFieldName.isUserInteractionEnabled = false
    self.buttonSave.setTitle( Localizator.instance.localize(string: "Key_update"), for: .normal)
           self.buttonClose.setTitle( Localizator.instance.localize(string: "Key_buttonClose"), for: .normal)
            break
        default : break
        }
        
    }
     func textFieldDelegate()
     {
        self.textFieldName.delegate = self
        self.textFieldPassword.delegate = self
        self.textFieldRole.delegate = self
        self.textFieldContact.delegate = self
        self.textFieldAddress.delegate = self
        self.textFieldRate.delegate = self
        self.textFieldHourly.delegate = self
     }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textFieldName.resignFirstResponder()
        self.textFieldPassword.resignFirstResponder()
        self.textFieldRole.resignFirstResponder()
        self.textFieldContact.resignFirstResponder()
        self.textFieldAddress.resignFirstResponder()
        self.textFieldRate.resignFirstResponder()
        self.textFieldHourly.resignFirstResponder()
        return true
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionSaveButton(_ sender: Any) {
        switch sceneType {
        case .addEmployeeListScene?:
           DBManager.shared.fetchEmployeeInfo()
           checkFieldsValidation()
           delegate?.loadEmployeeDetail()
            
            break
        case .addEmployeeScene?:
            DBManager.shared.updateEmployeeInfo(name: self.textFieldName.text!, pwd: textFieldPassword.text!, contact: textFieldRole.text!, address: textFieldContact.text!, role: textFieldAddress.text!, rate: textFieldRate.text!, hourly: textFieldHourly.text!)
            let fetchEmployeeUpdateInfo = DBManager.shared.fetchEmployeeInfo()
            let employeeInfoDict:[String:String] = ["name":fetchEmployeeUpdateInfo[0].EmployeeName,"password":fetchEmployeeUpdateInfo[0].password,"role":fetchEmployeeUpdateInfo[0].role,"contact":fetchEmployeeUpdateInfo[0].contact,"address":fetchEmployeeUpdateInfo[0].address,"rate":fetchEmployeeUpdateInfo[0].rate,"hourly":fetchEmployeeUpdateInfo[0].hourly]
            UserDefaults.standard.set(employeeInfoDict, forKey: "employeeInfoDict")
            let result = UserDefaults.standard.value(forKey: "employeeInfoDict")
            print(result!)
            showDefaultAlertViewWith(alertTitle:Localizator.instance.localize(string: "Key_success"), alertMessage:Localizator.instance.localize(string: "key_upadteSuccess"), okTitle: Localizator.instance.localize(string: "Key_ok"), currentViewController: self)
            delegate?.loadEmployeeUpdateDetail()
            break
        default : break
        }
        
        
}
    
    @IBAction func actionCloseButton(_ sender: Any) {
        
        switch sceneType {
        case .addEmployeeListScene?:
            self.view.removeFromSuperview()
            
            break
        case .addEmployeeScene?:
            self.view.removeFromSuperview()
            
            
            break
        default : break
        }
        
    }
    func checkFieldsValidation(){
        if ((textFieldName.text != "") && (textFieldPassword.text != "")&&(textFieldContact.text != "")&&(textFieldAddress.text != "")&&(textFieldRole.text != "")&&(textFieldRate.text != "")&&(textFieldHourly.text != "")){
            DBManager.shared.insertIntoPOSEmployee(name: self.textFieldName.text!, pwd: textFieldPassword.text!, contact: textFieldRole.text!, address: textFieldContact.text!, role: textFieldAddress.text!, rate: textFieldRate.text!, hourly: textFieldHourly.text!)
            let alertController = UIAlertController(title: Localizator.instance.localize(string: "Key_save"), message: Localizator.instance.localize(string: "Key_inserted"), preferredStyle: .alert)
            let okAction = UIAlertAction(title: Localizator.instance.localize(string: "Key_ok"), style: .default, handler: {
                alert -> Void in
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if ((textFieldName.text == "") && (textFieldPassword.text == "")&&(textFieldContact.text == "")&&(textFieldAddress.text == "")&&(textFieldRole.text == "")&&(textFieldRate.text == "")&&(textFieldHourly.text == "")) {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage: Localizator.instance.localize(string: "Key_AlertAllFieldEnter"), okTitle: Localizator.instance.localize(string: "Key_dismiss"), currentViewController: self)
        }
        else if ((self.textFieldPassword.text == "") && (self.textFieldName.text != "") && (self.textFieldRole.text != "") && (self.textFieldContact.text != "")) {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage: Localizator.instance.localize(string: "key_AlertPassword"), okTitle: Localizator.instance.localize(string: "Key_dismiss"), currentViewController: self)
        }
        else if (textFieldName.text  == "")  {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage: Localizator.instance.localize(string: "Key_AlertName"), okTitle: Localizator.instance.localize(string: "Key_ok"), currentViewController: self)
        }
        else if (textFieldPassword.text  == "") {
            
            showDefaultAlertViewWith(alertTitle:Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage: Localizator.instance.localize(string: "key_AlertPassword"), okTitle: Localizator.instance.localize(string: "Key_ok"), currentViewController: self)
        }
            
        else if(self.textFieldContact.text == "") {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage:Localizator.instance.localize(string: "Key_AlertContact"), okTitle: Localizator.instance.localize(string: "Key_dismiss"), currentViewController: self)
        }
        else if(self.textFieldAddress.text == "") {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage:Localizator.instance.localize(string: "Key_AlertAddress"), okTitle: Localizator.instance.localize(string: "Key_dismiss"), currentViewController: self)
        }
        else if(self.textFieldRole.text == "") {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage:Localizator.instance.localize(string: "Key_AlertRole"), okTitle: Localizator.instance.localize(string: "Key_dismiss"), currentViewController: self)
        }
        else if(self.textFieldRate.text == "") {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage:Localizator.instance.localize(string: "Key_AlertRate"), okTitle: Localizator.instance.localize(string: "Key_dismiss"), currentViewController: self)
        }
        else if(self.textFieldHourly.text == "") {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage:Localizator.instance.localize(string: "Key_AlertHourly"), okTitle: Localizator.instance.localize(string: "Key_dismiss"), currentViewController: self)
        }
        else {
            
            showDefaultAlertViewWith(alertTitle: Localizator.instance.localize(string: "Key_ErrorMsg"), alertMessage:Localizator.instance.localize(string: "Key_AlertMsg"), okTitle: Localizator.instance.localize(string: "Key_dismiss"), currentViewController: self)
        }
    }
    
}

