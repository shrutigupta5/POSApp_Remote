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
    var activeField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldDelegate()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
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
        
        DBManager.shared.insertIntoPOSEmployee(name: self.textFieldName.text!, pwd: textFieldPassword.text!, contact: textFieldRole.text!, address: textFieldContact.text!, role: textFieldAddress.text!, rate: textFieldRate.text!, hourly: textFieldHourly.text!)
        showDefaultAlertViewWith(alertTitle:Localizator.instance.localize(string: "Key_success"), alertMessage:Localizator.instance.localize(string: "Key_inserted"), okTitle: Localizator.instance.localize(string: "Key_ok"), currentViewController: self)
        
}
    
    @IBAction func actionCloseButton(_ sender: Any) {
        self.view.removeFromSuperview()
        delegate?.loadEmployeeDetail()
        
    }
    
}

