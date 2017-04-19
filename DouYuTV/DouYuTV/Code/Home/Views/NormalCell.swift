//
//  NormalCell.swift
//  DouYuTV
//
//  Created by mwj on 17/4/14.
//  Copyright © 2017年 MWJ. All rights reserved.
//

import UIKit
import Kingfisher

class NormalCell: UICollectionViewCell {

    
    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var titelLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onLineBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var anchor : AnchorModel? {
        didSet{
            guard let anchor = anchor else { return }
            
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = String(format: "%.1f万在线", CGFloat(CGFloat(anchor.online)/10000.0))
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            onLineBtn.setTitle(onlineStr, for: .normal)
            titelLabel.text = anchor.room_name
            nickNameLabel.text = anchor.nickname
            guard let imgURL = URL(string: anchor.vertical_src) else{ return }
            bgImgView.kf.setImage(with: imgURL)
        }
    }

}
