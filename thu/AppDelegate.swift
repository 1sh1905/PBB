//
//  AppDelegate.swift
//  thu
//
//  Created by TRI TRAN on 4/10/17.
//  Copyright © 2017 TRI TRANthutran. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject:AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let parseConfig = ParseClientConfiguration {(ParseMutableClientConfiguration) in
            ParseMutableClientConfiguration.applicationId = "photobulletinboard1234567890asdfghjkl"
            ParseMutableClientConfiguration.clientKey = "photobulletinboardkey1234567890asdfghjkl"
            ParseMutableClientConfiguration.server = "http://photobulletinboard.herokuapp.com/parse"
            
            
        }
       // login()
        Parse.initializeWithConfiguration(parseConfig)
        
        //color wondown
        window?.backgroundColor = .whiteColor()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func login() {
        
        // remember user's login
        let username : String? = NSUserDefaults.standardUserDefaults().stringForKey("username")
        
        // if loged in
        if username != nil {
            
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let myTabBar = storyboard.instantiateViewControllerWithIdentifier("tabBar") as! UITabBarController
            window?.rootViewController = myTabBar
        }
        
    }
    

}

