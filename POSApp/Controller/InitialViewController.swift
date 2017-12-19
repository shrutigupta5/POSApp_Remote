//
//  InitialViewController.swift
//  POSApp
//
//  Created by webwerks on 06/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var labelAlreadyAMember: DesignButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      self.labelAlreadyAMember.setTitle(Localizator.instance.localize(string: "Key_AlreadyMember"), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionSigninSignupButton(_ sender: Any) {
        let storyB = UIStoryboard.init(name: "Main", bundle: nil)
        let  baseVC:RegisterViewController = storyB.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        let scene = SceneType.InitialScene
        baseVC.sceneType = scene
        self.navigationController?.pushViewController(baseVC, animated: true)
        
    }
}
