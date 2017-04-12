//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by mwj on 17/4/6.
//  Copyright © 2017年 MWJ. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var colletionView : UICollectionView = {[weak self] in
    
        let layout = UICollectionViewFlowLayout()
        let colletionView = UICollectionView()
        
        
        return colletionView
    }()
    
    // MARK:- 系统回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.purple
        
        self.setUpUI()
    }
    

}
extension HomeViewController{

    fileprivate func setUpUI(){

//        view.addSubview(colletionView)
        self.setNavigationBar()
    }
    fileprivate func setNavigationBar(){
        //左
        let leftItem = UIButton()
        leftItem.setImage(UIImage(named: "logo"), for: .normal)
        leftItem.sizeToFit()
//        leftItem.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 66, height: 26))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftItem)
    }
}
