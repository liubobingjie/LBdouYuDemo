//
//  CycleModel.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/23.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    // 标题
   @objc var title : String = ""
    // 展示的图片地址
   @objc var pic_url : String = ""
    // 主播信息对应的模型对象
    var anchor : AnchorModel?
    //主播信息
    @objc var room:[String:Any]? {
        didSet{
            guard let room = room else{return}
            anchor = AnchorModel(dict: room)
        }
    }
    init(dic:[String:Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
