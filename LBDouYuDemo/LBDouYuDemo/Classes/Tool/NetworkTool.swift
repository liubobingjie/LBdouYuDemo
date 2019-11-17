//
//  NetworkTool.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/15.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType{
    case get
    case post
}

class NetworkTool: NSObject {
    class func requestData(type:MethodType ,URLString:String ,parameters : [String:String]? = nil,finishedCallback:@escaping (_ result:Any)->()){
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters:parameters).responseJSON { (response) in
            //guard 校验result是否有值
            //print(response)
            guard let result = response.result.value else{
                print("校验result请求报错了")
                return
            }
            //如果有值直接将结果回调出去
            finishedCallback(result)
            
        }

        
      
        
    }
    

}
