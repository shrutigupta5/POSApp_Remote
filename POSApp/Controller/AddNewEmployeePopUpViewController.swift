//
//  AddNewEmployeePopUpViewController.swift
//  POSApp
//
//  Created by Shruti Gupta on 19/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class AddNewEmployeePopUpViewController: UIViewController {

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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
