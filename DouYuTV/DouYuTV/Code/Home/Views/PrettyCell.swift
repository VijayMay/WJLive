//
//  PrettyCell.swift
//  DouYuTV
//
//  Created by mwj on 17/4/14.
//  Copyright © 2017年 MWJ. All rights reserved.
//

import UIKit

class PrettyCell: UICollectionViewCell {

    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onLineLabel: UILabel!
    @IBOutlet weak var bgImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var anchor : AnchorModel? {
        didSet{
            guard let anchor = anchor else{ return }
            onLineLabel.text = "\(anchor.online)在线"
            nickNameLabel.text = anchor.nickname
            cityBtn.setTitle(anchor.anchor_city, for: .normal)
            let imgURL = URL(string: anchor.vertical_src)
            bgImgView.kf.setImage(with: imgURL)
        }
    }
    
}
