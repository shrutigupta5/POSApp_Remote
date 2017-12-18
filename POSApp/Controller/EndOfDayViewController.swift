//
//  EndOfDayViewController.swift
//  RestaurantMannegmentDemo1
//
//  Created by Shruti Gupta on 29/11/17.
//  Copyright © 2017 Neosofttech Technologies. All rights reserved.
//

import UIKit

class EndOfDayViewController: UIViewController {

    @IBOutlet weak var buttonReserveEod: DesignButton!
    @IBOutlet weak var buttonEodReport: DesignButton!
    @IBOutlet weak var buttonEod: DesignButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomColor()
        localization()
        // Do any additional setup after loading the view.
        
    }
    func localization()
    {
        self.buttonEod.setTitle(Localizator.instance.localize(string: "Key_eod"), for: .normal)
        self.buttonReserveEod.setTitle(Localizator.instance.localize(string: "Key_reserveEod"), for: .normal)
        self.buttonEodReport.setTitle(Localizator.instance.localize(string: "Key_eodReport"), for: .normal)
    }
    
    func setCustomColor(){
    
    buttonEod.backgroundColor = UIColor.customLightBlue
    buttonReserveEod.backgroundColor = UIColor.customLightBlue
    buttonEodReport.backgroundColor = UIColor.customLightBlue
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
