//
//  AmuseMenuViewCell.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/30.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
private let kMrenCellID = "kMrenCellID"
class AmuseMenuViewCell: UICollectionViewCell {
    
    var group:[AnchorGroupModel]?{
        didSet{
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kMrenCellID)
       
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: collectionView.frame.size.width / 4, height: collectionView.frame.size.height / 2)
    }

}
extension AmuseMenuViewCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMrenCellID, for: indexPath) as! CollectionGameCell
        
        
        return cell
    }
    
    
}
