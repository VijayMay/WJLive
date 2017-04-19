//
//  RecommendViewController.swift
//  DouYuTV
//
//  Created by mwj on 17/4/14.
//  Copyright © 2017年 MWJ. All rights reserved.
//

import UIKit

private let kCellMargin : CGFloat = 10
private let kNormalCellW = (kScreenW - 3*kCellMargin)/2.0
private let kNormalCellH = kNormalCellW * 3/4
private let kPrettyCellH = kNormalCellW * 4/3
private let kHeadViewH : CGFloat = 50.0

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kLiveHeadViewID = "kLiveHeadViewID"


class RecommendViewController: UIViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kCellMargin
        layout.itemSize = CGSize(width: kNormalCellW, height: kNormalCellH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kCellMargin, bottom: 0, right: kCellMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadViewH)
        let collectionView = UICollectionView(frame: (self?.view.frame)!, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib (nibName: "NormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib (nibName: "PrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib (nibName: "LiveHeadView", bundle:nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kLiveHeadViewID)
        
        return collectionView
    }()
    // MARK:-系统回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        loadData()
    }
    
}

// MARK:- 添加子试图
extension RecommendViewController {

    fileprivate func setupUI(){
        
        view.addSubview(collectionView)
        
    }
}

// MARK:- UICollectionViewDataSource
extension RecommendViewController : UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return recommendVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendVM.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell?
        
        if(indexPath.section == 1){
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! PrettyCell
            let anchor : AnchorModel = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            prettyCell.anchor = anchor
            cell = prettyCell
            
        }else{
            let normalCell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NormalCell
            let anchor : AnchorModel = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            normalCell.anchor = anchor
            cell = normalCell
        }

        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kLiveHeadViewID, for: indexPath) as! LiveHeadView
        let group = recommendVM.anchorGroups[indexPath.section]
        
        headView.group = group
        
        return headView
    }
    
}

// MARK:- UICollectionViewDelegate
extension RecommendViewController : UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("第\(indexPath.section)组 第\(indexPath.item)个")
        
        
    }
}
// MARK:- 
extension RecommendViewController : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalCellW, height: kPrettyCellH)
        }
        return CGSize(width: kNormalCellW, height: kNormalCellH)
    }
}
// MARK:- 网络请求

extension RecommendViewController{

    fileprivate func loadData(){
    
        recommendVM.requestData {
            self.collectionView.reloadData()
        }
    }
    
}




















