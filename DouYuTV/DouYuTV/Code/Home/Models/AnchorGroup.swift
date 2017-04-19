//
//  AnchorGroup.swift
//  DouYuTV
//
//  Created by mwj on 17/4/14.
//  Copyright © 2017年 MWJ. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    // MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    var room_list : [[String : NSObject]]? {
        didSet{
            guard let room_list = room_list else{ return }
            
            for dict in room_list{
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    // MARK:- 自定义构造函数
    override init() {
        
    }
    
    var icon_name : String = "home_header_normal"
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
