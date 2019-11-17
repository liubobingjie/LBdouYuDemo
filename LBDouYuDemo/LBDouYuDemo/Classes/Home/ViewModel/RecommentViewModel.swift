//
//  RecommentViewModel.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/16.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class RecommentViewModel: NSObject {
     lazy var anchorGroup:[AnchorGroupModel] = [AnchorGroupModel]()
     lazy var bigDataGroup :AnchorGroupModel = AnchorGroupModel()
     lazy var prettyGroup: AnchorGroupModel = AnchorGroupModel ()

}

extension RecommentViewModel{
    func requestData(finishCallBack:@escaping ()->()){
        //定义参数
        let parame = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()
        ]
        
        let groupPatch = DispatchGroup()
        
        groupPatch.enter()
        //请求推荐数据
        NetworkTool.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters:["time":NSDate.getCurrentTime()] ){(result) in
            guard let resultDict = result as? [String:Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String:Any]] else{return}
           // let group = AnchorGroupModel()
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray{
                let anchor = AnchorModel(dict:dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            groupPatch.leave()
        }
        
        
        //请求t颜值数据
         groupPatch.enter()
        NetworkTool.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parame ){(result) in
            guard let resultDict = result as? [String:Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String:Any]] else{return}
           // let group = AnchorGroupModel()
            self.prettyGroup.tag_name = "颜值"
             self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray{
                let anchor = AnchorModel(dict:dict)
                 self.prettyGroup.anchors.append(anchor)
            }
            groupPatch.leave()
        }
        
        //请求游戏数据
        groupPatch.enter()
        NetworkTool.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parame ){(result) in
            guard let resultDict = result as? [String:Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String:Any]] else{return}
            
            for dicte in dataArray{
                let group = AnchorGroupModel(dict: dicte)
                self.anchorGroup.append(group)
            }
         groupPatch.leave()
        }
        
        
        groupPatch.notify(queue: DispatchQueue.main) {
            self.anchorGroup.insert(self.prettyGroup, at: 0)
            self.anchorGroup.insert(self.bigDataGroup, at: 0)
            print(self.anchorGroup.count)
            finishCallBack()
            
        }
        
    }
}
