//
//  AmuseMenuView.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/30.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class AmuseMenuView: UIView {
    
    // MARK: 定义属性
    var groups : [AnchorGroupModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIView.AutoresizingMask.init(rawValue: 0)
        collectionView.delegate = self
        
       // collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kMenuCellID)
        collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = collectionView.bounds.size
    }

   
}
extension AmuseMenuView {
    class func amuseMenuView()->AmuseMenuView{
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}
extension AmuseMenuView:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil {return 0}
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        
        return pageNum
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuViewCell
        
      setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func setupCellDataWithCell(cell : AmuseMenuViewCell, indexPath : IndexPath){
        // 0页: 0 ~ 7
        // 1页: 8 ~ 15
        // 2也: 16 ~ 23
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        //判段越界
        if (endIndex > groups!.count - 1){
            endIndex = groups!.count - 1
        }
        
        cell.group = Array(groups![startIndex...endIndex])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
    
}
