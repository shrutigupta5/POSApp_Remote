//
//  InitialViewController.swift
//  POSApp
//
//  Created by webwerks on 06/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionSigninSignupButton(_ sender: Any) {
        let storyB = UIStoryboard.init(name: "Main", bundle: nil)
        let  baseVC:BaseViewController = storyB.instantiateViewController(withIdentifier: "BaseViewController") as! BaseViewController
        let scene = SceneType.InitialScene
        baseVC.sceneType = scene
        self.navigationController?.pushViewController(baseVC, animated: true)
    }
    
    

}
