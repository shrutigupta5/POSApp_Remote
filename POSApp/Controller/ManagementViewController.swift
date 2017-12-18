//
//  ManagementViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta on 29/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class ManagementViewController: UIViewController {

    @IBOutlet weak var buttonShift: DesignButton!
    @IBOutlet weak var buttontimeStamp: DesignButton!
    @IBOutlet weak var buttonEmployee: DesignButton!
    @IBOutlet weak var buttonCashInOut: DesignButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        localization()
        // Do any additional setup after loading the view.
    }
    func localization()
    {
      self.buttonShift.setTitle(Localizator.instance.localize(string: "Key_shift"), for: .normal)
        self.buttontimeStamp.setTitle(Localizator.instance.localize(string: "Key_timeStamp"), for: .normal)
         self.buttonEmployee.setTitle(Localizator.instance.localize(string: "Key_addEmployee"), for: .normal)
         self.buttonCashInOut.setTitle(Localizator.instance.localize(string: "Key_cashInOut"), for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionShiftButton(_ sender: Any) {
        
    }
    
    @IBAction func actionTimeStampButton(_ sender: Any) {
    }
    
    @IBAction func actionEmployeeButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let forgetVC = storyboard.instantiateViewController(withIdentifier: "AddEmployeeViewController") as! AddEmployeeViewController
        self.navigationController?.pushViewController(forgetVC,animated: true)
    }
    @IBAction func actionCashInOutButton(_ sender: Any) {
    }
}
