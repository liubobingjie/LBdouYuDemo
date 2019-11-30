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
    lazy var cycleModels:[CycleModel] = [CycleModel]()
    
     lazy var games : [BaseGameModel] = [BaseGameModel]()

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
    
    func requiredCycleData(finishCallBack:@escaping ()->())  {
        NetworkTool.requestData(type: MethodType.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version":"2.300"]) { (result) in
            guard let resultDic = result as? [String:Any] else {return}
            
            guard let dataArray = resultDic["data"] as? [[String:Any]] else {return}
            
            //字典转模型
            for dict in dataArray {
              self.cycleModels.append(CycleModel(dic: dict))
                
            }
            finishCallBack()
            
            
        }
    }
    
    //获取游戏图片主题
    func loadAllGameData(finishCallBack:@escaping ()->()){
        
        NetworkTool.requestData(type: MethodType.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":"game"]) { (result) in
            guard let resultDic = result as? [String:Any] else {return}
            
            print(resultDic)
            
            guard let dataArray = resultDic["data"] as? [[String:Any]] else {return}
             print(dataArray)
            //字典转模型
            for dict in dataArray {
                self.games.append(BaseGameModel(dic:dict))
                
            }
            finishCallBack()
            
            
        }
        
        
    }
    
    
    
}
