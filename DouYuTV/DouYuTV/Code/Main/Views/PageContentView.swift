//
//  PageContentView.swift
//  DouYuTV
//
//  Created by mwj on 17/4/13.
//  Copyright © 2017年 MWJ. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {

    // MARK:- 自定义属性
    fileprivate var childVCs : [UIViewController]
    fileprivate weak var superVC : UIViewController?
    weak var delegate : PageContentViewDelegate?
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isDelegateScroll : Bool = false
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
        
        cell.contentView.addSubview(childVC.view)

        return cell
    }
    
    
}
// MARK:- UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDelegateScroll = false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll------> \(scrollView.contentOffset.x)")
        //delegate 滚动不需要处理
        if  isDelegateScroll { return }
        
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //判断滑动方向
        let currentOffsetX = scrollView.contentOffset.x
        let scrollView_w = scrollView.frame.width
        if currentOffsetX > startOffsetX { // 左滑
            progress = currentOffsetX / scrollView_w - floor(currentOffsetX / scrollView_w)
            sourceIndex = Int(currentOffsetX/scrollView_w)
            targetIndex = sourceIndex + 1
            print("sourceIndex === \(sourceIndex) targetIndex=== \(targetIndex)")
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            if currentOffsetX - startOffsetX == scrollView_w {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//右滑
            progress = 1 - (currentOffsetX/scrollView_w - floor(currentOffsetX / scrollView_w))
            targetIndex = Int(currentOffsetX/scrollView_w)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
            if currentOffsetX - startOffsetX == scrollView_w {
                progress = 1
                targetIndex = sourceIndex
            }
        }
        
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
// MARK:-向外暴露的方法
extension PageContentView {
    
    func setCurrentIndex(_ currentIndex : Int){
        isDelegateScroll = true
        collectionView.setContentOffset(CGPoint(x: kScreenW * CGFloat(currentIndex), y: 0), animated:true)
    }
}














