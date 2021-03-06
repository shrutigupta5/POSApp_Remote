//
//  AppDelegate.swift
//  POSApp
//
//  Created by webwerks on 06/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import TwitterKit
import Google
import GoogleSignIn
import LinkedinSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var userDefaultsDictionary  : [String:AnyObject]? = [:]
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        TWTRTwitter.sharedInstance().start(withConsumerKey:"EapWRisei7LRFQltbO0NarpYJ", consumerSecret:"V3Q0uOp2RlObzNcTQTvgjcdaaotB0pFnIpcz2EvCQNk929EPQE")
        
        let userDefaults = UserDefaults.standard
        let language = NSLocale.preferredLanguages.first
        let Dict : Dictionary = NSLocale.components(fromLocaleIdentifier: language!)
        let currentLanguageCode = Dict["kCFLocaleLanguageCodeKey"]
        print("language : \(String(describing: currentLanguageCode) )")
        POSManger.shared.localizeString = (language )!
        
        
        self.userDefaultsDictionary = userDefaults.value(forKey: "userInfoDict") as? [String : AnyObject]

                if(userDefaultsDictionary == nil)
                {

                    let storyBord = UIStoryboard.init(name: "Main", bundle: nil)
                    let loginVC = storyBord.instantiateViewController(withIdentifier: "InitialViewController")as! InitialViewController
                    let navigationController = self.window?.rootViewController as! UINavigationController
                    navigationController.pushViewController(loginVC, animated: true)
                }
                else{

                    let storyB = UIStoryboard.init(name: "Main", bundle: nil)
                    let  navVC = storyB.instantiateViewController(withIdentifier: "NavVc") as! UINavigationController
                    self.window?.rootViewController = navVC

                }
        // Override point for customization after application launch.
         return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
        
    }
      func application1(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL!,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    func application(application: UIApplication,
                     openURL url: NSURL,
                     sourceApplication: String?,
                     annotation: AnyObject) -> Bool {
        
        // Linkedin sdk handle redirect
        if LinkedinSwiftHelper.shouldHandle(url as URL) {
            return LinkedinSwiftHelper.application(application,
                                                   open: url as URL,
                                                   sourceApplication: sourceApplication,
                                                   annotation: annotation
            )
        }
        
        return false
    }
   
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
       
    }
   
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
        if DBManager.shared.createDatabase() {
        }
      
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

