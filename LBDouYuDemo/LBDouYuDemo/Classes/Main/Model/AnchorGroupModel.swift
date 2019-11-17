//
//  AnchorGroupModel.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/17.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class AnchorGroupModel: NSObject {
   @objc var room_list:[[String:Any]]?{
        didSet{
            guard let room_list = room_list else{return}
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    //组显示的标题
   @objc var tag_name:String = ""
   @objc var icon_name:String = "home_header_hot"
    @objc lazy var anchors : [AnchorModel] = [AnchorModel]()
    override init() {
        
    }
    init(dict:[String:Any]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }


}
