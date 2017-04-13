//
//  UIBarButtonItem-Extension.swift
//  DouYuTV
//
//  Created by mwj on 17/4/12.
//  Copyright © 2017年 MWJ. All rights reserved.
//

import UIKit

extension UIBarButtonItem{

    convenience init(imageName : String, highImageName : String = "", size : CGSize = CGSize.zero) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView: btn)
    }
}
