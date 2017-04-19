//
//  RecommendViewModel.swift
//  DouYuTV
//
//  Created by mwj on 17/4/14.
//  Copyright © 2017年 MWJ. All rights reserved.
//

import UIKit

class RecommendViewModel {

    // MARK:- 懒加载属性
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var hotGroup : AnchorGroup = AnchorGroup()
    lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
}

extension RecommendViewModel{

    func requestData(_ finishCallback : @escaping ()->()) {
        // 定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        //创建队列
        let dGroup = DispatchGroup()
        
        //进队列
        dGroup.enter()
        //热门数据 http://capi.douyucdn.cn/api/v1/getbigDataRoom
        NetworkTools.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" :Date.getCurrentTime]) { (result) in
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            let hotGroup = AnchorGroup()
            hotGroup.icon_name = "home_header_hot"
            hotGroup.tag_name = "热门"
            for dict in dataArray {
                hotGroup.anchors.append(AnchorModel(dict: dict))
            }
            self.hotGroup = hotGroup
            //出队列
            dGroup.leave()
        }
        //进队列
        dGroup.enter()
        //颜值数据  http://capi.douyucdn.cn/api/v1/getVerticalRoom
        NetworkTools.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            guard let resultDict = result as? [String : Any] else{ return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            let prettyGroup = AnchorGroup()
            prettyGroup.icon_name = "home_header_phone"
            prettyGroup.tag_name = "颜值"
            for dict in dataArray {
               prettyGroup.anchors.append( AnchorModel(dict: dict))
            }
            self.prettyGroup = prettyGroup
            //出队列
            dGroup.leave()
        }
        //进队列
        dGroup.enter()
        // 请求2-12部分游戏数据 http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1474252024
        NetworkTools.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else{ return }
            
            for dict in dataArray{
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            
            //出队列
            dGroup.leave()

        }
        //数据都出列了，进行排序
        dGroup.notify(queue: DispatchQueue.main){
            
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.hotGroup, at: 0)
            //完成回调
            finishCallback()
        }
        
        
        
    
        
        
        
    }
}
