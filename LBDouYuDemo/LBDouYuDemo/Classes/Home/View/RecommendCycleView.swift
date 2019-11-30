//
//  RecommendCycleView.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/23.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

private let cycleCellID = "cycleCellid"

class RecommendCycleView: UIView {
    
    var cycleTimer:Timer?
    
    var cycleModels:[CycleModel]?{
        didSet{
            collectionView.reloadData()
            //设计page
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //默认滚动动刀中间
            let indexPath  = NSIndexPath(item: (cycleModels?.count ?? 0) * 20, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionView.ScrollPosition.left, animated:false)
            //处理定时器
            removeTimer()
            addCycleTimer()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIView.AutoresizingMask.init(rawValue: 0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CycleViewCell", bundle: nil), forCellWithReuseIdentifier: cycleCellID)
        
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cycleCellID)
      
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
          //设置布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
       
        
    }
   

}
extension RecommendCycleView : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cycleCellID, for: indexPath) as! CycleViewCell
        
        let cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        cell.cycleModel = cycleModel
        
    
        return cell
        
    }
    
    //代理协议
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取滚动的偏移量
        let offetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
         //pageControl.currentPage =  Int(offetX / scrollView.bounds.width)
       pageControl.currentPage =  Int(offetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
    }
    //开始手动拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
     //开始手动拖拽
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        removeTimer()
        addCycleTimer()
    }
    
    
}
extension RecommendCycleView{
    class func recommendCycleView()->RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

extension RecommendCycleView {
    private func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(RecommendCycleView.scollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoop.Mode.common)
    }
    private func removeTimer(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    @objc public func scollToNext(){
        let currentOffSetX = collectionView.contentOffset.x
        let offSetX = currentOffSetX + collectionView.bounds.width
        
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: true)
        
    }
    
    
}
