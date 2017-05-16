//
//  navVC.swift
//  thu
//
//  Created by TRI TRAN on 4/24/17.
//  Copyright © 2017 TRI TRANthutran. All rights reserved.
//

import UIKit

class navVC: UINavigationController {

    // default func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // color of title at the top in nav controller
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        // color of buttons in nav controller
        self.navigationBar.tintColor = .whiteColor()
        
        // color of background of nav controller
        self.navigationBar.barTintColor = UIColor(red: 18.0 / 255.0, green: 86.0 / 255.0, blue: 136.0 / 255.0, alpha: 1)
        
        // disable translucent
        self.navigationBar.translucent = false
    }
    
    
    // white status bar function
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    

   
    
    
    
    
}
