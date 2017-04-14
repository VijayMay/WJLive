//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by mwj on 17/4/6.
//  Copyright © 2017年 MWJ. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        
        let titleFrame = CGRect(x: 0, y:kNavigationBarH + kStatusBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let pageTitleView = PageTitleView(frame: titleFrame, titles: titles)
        pageTitleView.delegate = self
        return pageTitleView
    }()
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        //确定frame
        let contentH = kScreenH - kTabbarH - kNavigationBarH - kStatusBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        //添加子控制器
        var child_VCs = [UIViewController]()
        child_VCs.append(RecommendViewController())
        child_VCs.append(GameViewController())
        child_VCs.append(AmuseViewController())
        child_VCs.append(FunnyViewController())
        let pageContentView = PageContentView(frame: contentFrame, childVCs: child_VCs, superVC: self!)
        pageContentView.delegate = self
        return pageContentView
    }()
    // MARK:- 系统回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.setUpUI()
    }
    

}
// MARK:-添加子试图
extension HomeViewController{

    fileprivate func setUpUI(){
        
        automaticallyAdjustsScrollViewInsets = false
        setNavigationBar()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
    fileprivate func setNavigationBar(){
        //左
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        //右
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qcItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)

        navigationItem.rightBarButtonItems = [historyItem,searchItem,qcItem]
        
    }
}
// MARK:- PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate{

    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }

}
// MARK:- PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate{

    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}








