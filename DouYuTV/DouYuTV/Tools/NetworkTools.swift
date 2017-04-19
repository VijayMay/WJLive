//
//  NetworkTools.swift
//  DouYuTV
//
//  Created by mwj on 17/4/14.
//  Copyright © 2017年 MWJ. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{
    case get
    case post
}
class NetworkTools {

    class func requestData(type: MethodType, urlString: String, parameters: [String : Any]? = nil,fnishedCallBack: @escaping (_ result : Any) -> ()) {
        
        //获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        //发送网络请求
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
            //获取结果
            guard let result = response.result.value else{
                print(response.result.error ?? "数据异常")
                return
            }
            //将结果返回
            fnishedCallBack(result)
        }
    }
}
