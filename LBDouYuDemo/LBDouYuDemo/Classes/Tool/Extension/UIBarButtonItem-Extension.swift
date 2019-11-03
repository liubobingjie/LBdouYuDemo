//
//  UIBarButtonItem-Extension.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/3.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
    /*类方法创建
    class func creatItem(imageName:String,hightImageName:String ,size:CGSize)->UIBarButtonItem{
        
        let btn = UIButton()
        btn.setImage(UIImage(named: ""), for: UIControl.State.normal)
        btn.setImage(UIImage(named: hightImageName), for: UIControl.State.highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }*/
    
    
    //便利构造函数 1.必须convenience 开头，2.必须调用一个设计函数
    convenience init(imageName:String, highImageName: String , size:CGSize = CGSize.zero){
        let btn  = UIButton()
        btn.setImage(UIImage(named: imageName), for: UIControl.State.normal)
        btn.setImage(UIImage(named: highImageName), for: UIControl.State.highlighted)
        if(size == CGSize.zero){
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView:btn)
    }
    
    
    
}
