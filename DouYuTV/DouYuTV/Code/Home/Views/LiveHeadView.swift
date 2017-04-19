//
//  LiveHeadView.swift
//  DouYuTV
//
//  Created by mwj on 17/4/14.
//  Copyright © 2017年 MWJ. All rights reserved.
//

import UIKit

class LiveHeadView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var group : AnchorGroup? {
        
        didSet{
            
           guard let group = group else { return }
            
            titleLabel.text = group.tag_name
            iconImgView.image = UIImage(named: group.icon_name)
            
        }
    }
    

}
