//
//  PageContentView.swift
//  DouYuTV
//
//  Created by mwj on 17/4/13.
//  Copyright © 2017年 MWJ. All rights reserved.
//

import UIKit

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    // MARK:- 自定义属性
    fileprivate var childVCs : [UIViewController]
    fileprivate weak var superVC : UIViewController?
    
    // MARK:-懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        
        return collectionView
    }()
    
    //自定义构造函数
    init(frame: CGRect, childVCs: [UIViewController], superVC: UIViewController) {
        self.childVCs = childVCs
        self.superVC = superVC
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK:- 添加子试图
extension PageContentView {

    fileprivate func setupUI(){
        //将所有的子控制器添加父控制器中
        for childVC in childVCs {
            superVC?.addChildViewController(childVC)
        }
        //添加collectionView
        addSubview(collectionView)
        collectionView.frame = bounds
    }
    
}
// MARK:- UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)

        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        childVC.view.backgroundColor = UIColor.randomColor()
        cell.contentView.addSubview(childVC.view)

        return cell
    }
    
    
}
// MARK:- UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {


}















