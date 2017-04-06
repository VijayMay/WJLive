//
//  MainViewController.swift
//  DouYuTV
//
//  Created by mwj on 17/4/6.
//  Copyright © 2017年 MWJ. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Follow")
        addChildVC("Profile")
        
        
    }

    fileprivate func addChildVC(_ storyName : String){
    
        let childVC : UIViewController = UIStoryboard(name:storyName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVC)
    }
}
