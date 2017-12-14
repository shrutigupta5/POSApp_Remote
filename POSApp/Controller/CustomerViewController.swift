//
//  CustomerViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta on 29/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class CustomerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var tableViewDropDown: UITableView!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldCustmorContact: UITextField!
    @IBOutlet weak var buttonRoll: UIButton!
    @IBOutlet weak var viewLastName: DesignableView!
    @IBOutlet weak var viewContactNo: DesignableView!
    @IBOutlet weak var viewFirstName: DesignableView!
    @IBOutlet weak var viewRoll: DesignableView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var rollArray = ["val1", "val2", "val3", "val4", "val5", "val6", "val7"]
    var activeField: UITextField?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextFieldDelegate()
        setCustomColor()
        tableViewDropDown.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func keyboardWillShow(notification:NSNotification){
        
        var info = notification.userInfo!
        let kbSize: CGSize = ((info[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size)
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        var aRect: CGRect = self.view.frame
        aRect.size.height -= kbSize.height
//        if !aRect.contains(activeField!.frame.origin) {
//            self.scrollView.scrollRectToVisible(activeField!.frame, animated: true)
//        }
        
    }
    
    func keyboardWillHide(notification:NSNotification){
        
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    func setCustomColor(){
    
    self.viewFirstName.backgroundColor = UIColor.customLightBlue
    self.viewLastName.backgroundColor = UIColor.customLightBlue
    self.viewContactNo.backgroundColor = UIColor.customLightBlue
    self.viewRoll.backgroundColor = UIColor.customLightBlue
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rollArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewDropDown.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = rollArray[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableViewDropDown.cellForRow(at: indexPath)
        buttonRoll.setTitle(cell?.textLabel?.text, for: .normal)
        self.tableViewDropDown.isHidden = true
        
    }
    
    @IBAction func buttonRollAction(_ sender: Any) {
        
        // hiding and unhiding
        tableViewDropDown.isHidden = !tableViewDropDown.isHidden
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textFieldFirstName.resignFirstResponder()
        textFieldLastName.resignFirstResponder()
        textFieldCustmorContact.resignFirstResponder()
        return true
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    func setTextFieldDelegate(){
        
    textFieldFirstName.delegate = self
    textFieldLastName.delegate = self
    textFieldCustmorContact.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
