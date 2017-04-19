//
//  NSDate-Extenstion.swift
//  DouYuTV
//
//  Created by mwj on 17/4/18.
//  Copyright © 2017年 MWJ. All rights reserved.
//

import Foundation

extension Date{

    static func getCurrentTime() ->String{
    
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
