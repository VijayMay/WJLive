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
        
        return pageTitleView
    }()
    fileprivate lazy var pageContentView : PageContentView = {
        //确定frame
        let contentH = kScreenH - kTabbarH - kNavigationBarH - kStatusBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        //添加子控制器
        var child_VCs = [UIViewController]()
        for _ in 0..<4 {
            let viewController = UIViewController()
            viewController.view.backgroundColor = UIColor.randomColor()
            child_VCs.append(viewController)
        }
        let pageContentView = PageContentView(frame: contentFrame, childVCs: child_VCs, superVC: self)
        
        return pageContentView
    }()
    // MARK:- 系统回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.setUpUI()
    }
    

}
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
