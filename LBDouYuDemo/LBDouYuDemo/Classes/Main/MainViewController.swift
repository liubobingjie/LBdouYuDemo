//
//  MainViewController.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/10/20.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Follow")
        addChildVc("Profile")


    }
    fileprivate func addChildVc(_ storyName:String){
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        addChild(childVc)
        
    }

    

}
