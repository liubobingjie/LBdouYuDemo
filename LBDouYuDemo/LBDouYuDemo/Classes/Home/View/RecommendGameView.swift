//
//  RecommendGameView.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/23.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    var groups:[BaseGameModel]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        autoresizingMask = UIView.AutoresizingMask.init(rawValue: 0)
       // collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.dataSource = self
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
    
    

}
extension RecommendGameView{
    class func recommendGameView()->RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}
extension RecommendGameView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = groups![indexPath.item]
        
//        if(indexPath.item % 2 == 0){
//            cell.backgroundColor = UIColor.orange
//        }else{
//            cell.backgroundColor = UIColor.red
//        }
        
        return cell
    }
    
    
}
