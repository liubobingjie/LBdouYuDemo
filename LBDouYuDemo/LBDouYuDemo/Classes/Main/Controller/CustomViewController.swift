//
//  CustomViewController.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/30.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class CustomViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let systemGes = interactivePopGestureRecognizer else {return}
        guard let gesView = systemGes.view else {return}
        var count:uint = 0
//        let ivars =  class_copyIvarList(UIGestureRecognizer.self, &count)!
//        for i in 0..<count{
//            let ivar = ivars[Int(i)]
//            let name = ivar_getName(ivar)
//            print(String(cString: name!))
//        }
       let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObj = targets?.first else {return}
        print(targetObj)
        
      guard let target = targetObj.value(forKey: "target") else {return}
//        guard let action1 = targetObj.value(forKey: "action") else {return}
        let action1 = Selector(("handleNavigationTransition:"))
        
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action1)

    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
    

   

}
