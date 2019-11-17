//
//  NSDate+Extension.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/17.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

extension NSDate{
    class func getCurrentTime()->String{
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
    
    
}
