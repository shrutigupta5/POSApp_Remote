//
//  RestaurantConstant.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta on 17/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import Foundation
import UIKit

public enum SceneType{
    case InitialScene
    case SideMenuScene
    case CustomerScene
    case ManagementScene
}

func  showDefaultAlertViewWith(alertTitle:String, alertMessage:String, okTitle:String, currentViewController :UIViewController) {
    
    let alert = UIAlertController(title: alertTitle, message:alertMessage, preferredStyle:.alert)
    alert.addAction(UIAlertAction(title: okTitle, style: .default) { action in
    })
    currentViewController.present(alert, animated: true, completion: nil)
}

func createAttributedPlacedholderToTextField(currentTextField : UITextField, currentPlaceholderText : String) {
    
    currentTextField.attributedPlaceholder = NSAttributedString(string:currentPlaceholderText,attributes: [NSForegroundColorAttributeName: UIColor.white])
    
}

func applyAttributedNavigationBarTitleWith(currentTitle : String, currentNavigationController: UINavigationController) {
    
    currentNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    currentNavigationController.title = currentTitle
    
}
func isValidEmail(testStr:String) -> Bool {
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
    
}

func isValidPincode(value: String) -> Bool {
    
    var status : Bool = true
    
    if value.count < 3 {
        status = false
    }
    return status
}
