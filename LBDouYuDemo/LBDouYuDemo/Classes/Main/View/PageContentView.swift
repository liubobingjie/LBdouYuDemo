//
//  PageContentView.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/3.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate:class {
    func pageContentView(contentView:PageContentView ,progress:CGFloat, sourceIndex:Int,targetIndex:Int)
}

private let collectionIdenty = "collectionIdenty"

class PageContentView: UIView {
    
    private var childVCs:[UIViewController]
    private weak var parentViewController : UIViewController?
    
    private var isForbidScorllDelegate:Bool = false
    
    weak var delegate:PageContentViewDelegate?
    
    private var startOffSsetX :CGFloat = 0
    
    //懒加载
    private lazy var collectionView:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.bounces = false
        collection.dataSource = self
        collection.delegate = self
        
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionIdenty)
        
        return collection;
    }()
    

    init(frame: CGRect ,childVCs:[UIViewController] , parentViewController:UIViewController?) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension PageContentView{
    private func setupUI(){
        for childvc  in childVCs {
            parentViewController?.addChild(childvc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
        
        
    }
    
}

extension PageContentView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionIdenty, for: indexPath);
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }
    
    
}

extension PageContentView:UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScorllDelegate = false
        startOffSsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(isForbidScorllDelegate){
            return
        }
       
        var progress:CGFloat = 0
        var sourceIndex:Int = 0
        var targeIndex:Int = 0
        
         //判断左右滑动
        let currentOffsetX = scrollView.contentOffset.x
        if (currentOffsetX > startOffSsetX){//左滑
            //floor 取整函数
            progress = currentOffsetX / scrollView.bounds.width - floor(currentOffsetX / scrollView.bounds.width)
            sourceIndex = Int(currentOffsetX / scrollView.bounds.width)
            targeIndex = sourceIndex + 1
            if targeIndex >= childVCs.count{
                targeIndex = childVCs.count - 1
            }
            
            if(currentOffsetX - startOffSsetX == scrollView.bounds.width){
                progress = 1
                targeIndex = sourceIndex
            }
            
        }else{//右滑
             progress = 1 - (currentOffsetX / scrollView.bounds.width - floor(currentOffsetX / scrollView.bounds.width))
            
            targeIndex = Int(currentOffsetX / scrollView.bounds.width)
            
            sourceIndex = targeIndex + 1
            
            if(sourceIndex >= childVCs.count){
                sourceIndex = childVCs.count - 1
            }
        }
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targeIndex)
        
    }
}
//对方暴露一个方法接收值

extension PageContentView{
    func setupCurrentIndex(currentIndex:Int){
        isForbidScorllDelegate = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        
    }
}
