//
//  BaseViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta  on 20/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var signInContainerView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var signUpContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //  set segment control font size
   let attribute = NSDictionary(object: UIFont(name: "HelveticaNeue-Bold", size: 25.0)!, forKey: NSFontAttributeName as NSCopying)
    segmentControl.setTitleTextAttributes(attribute as [NSObject : AnyObject] , for: .normal)
    }

    @IBAction func segmentControlAction(_ sender: Any) {
        
        switch segmentControl.selectedSegmentIndex {
            
        case 0:
            print("Sign in segment selected")
            signUpContainerView.isHidden = true
            signInContainerView.isHidden = false
        case 1:
            print("Sign up segment selected")
            signUpContainerView.isHidden = false
            signInContainerView.isHidden = true
        default:
            break;
            
        }
    }
        


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
