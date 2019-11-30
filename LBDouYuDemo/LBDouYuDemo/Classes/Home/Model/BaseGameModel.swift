//
//  BaseGameModel.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/30.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    // MARK:- 定义属性
     @objc var tag_name : String = ""
     @objc var icon_url : String = ""
    
    
    
    init(dic:[String:Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
