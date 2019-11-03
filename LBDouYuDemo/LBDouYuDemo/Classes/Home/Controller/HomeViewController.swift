//
//  HomeViewController.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/3.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

private let kTitlesH:CGFloat = 40

class HomeViewController: UIViewController {
    fileprivate lazy var pageTitleView:PageTitleView = {[weak self] in
        
        let frame = CGRect(x: 0, y: 64, width:kScreenW , height: kTitlesH)
       let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        
        let titlesView = PageTitleView(frame: frame, titles: titles)
        titlesView.delegate = self
       // titlesView.backgroundColor = UIColor.orange
        return titlesView
    }()
    
    private lazy var pageContentView:PageContentView = {[weak self] in
        
        var childvc = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childvc.append(vc)
        }
        
        
        let contentViewH :CGFloat = kScreenH - kStatusBarH - kNavigationBarH - kTitlesH
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitlesH, width: kScreenW, height: contentViewH)
        
        let pageContentView = PageContentView(frame: frame, childVCs: childvc, parentViewController: self)
        pageContentView.delegate = self
        return pageContentView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Do any additional setup after loading the view.
    }
    

}
extension HomeViewController{
    private func setupUI(){
        //设置导航栏
        setNavUI()
        
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
        
        
    }
    
    private func setNavUI(){
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
       navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        //设置右边的按钮
        let size = CGSize(width: 40, height: 40)
        let historyBtn = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_click", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        
        navigationItem.rightBarButtonItems = [historyBtn,searchItem,qrcodeItem]
        
    }

}
extension HomeViewController:PageContentViewDelegate{
    
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, souceIndex: sourceIndex, targeIndex: targetIndex)
        
    }
    
    
}

extension HomeViewController:PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
       // print(index)
        
        pageContentView.setupCurrentIndex(currentIndex: index)
    }
    
    
}
