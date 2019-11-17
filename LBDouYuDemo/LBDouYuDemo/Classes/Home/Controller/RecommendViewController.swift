//
//  RecommendViewController.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/9.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

private let kItemMargin:CGFloat = 10
private let kItemW:CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH:CGFloat = kItemW * 3 / 4

private let kPrettyItemH:CGFloat = kItemW * 4 / 3
private let kHeadH:CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeardViewhID = "kHeardViewhID"
private let kPrettyCellID = "kPrettyCellID"

class RecommendViewController: UIViewController {
    //MARK:-懒加载
    private lazy var recommendVM:RecommentViewModel = RecommentViewModel()
    
    private lazy var colloectionView :UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadH)

        let colloection = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        colloection.backgroundColor = UIColor.white
        colloection.delegate = self
        colloection.dataSource = self
        colloection.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
         colloection.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        //colloection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        colloection.register(UINib(nibName: "CollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeardViewhID)
        //colloection.register(UICollectionReusableView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeardViewhID)
        return colloection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        colloectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        loadData()

    }
}
extension RecommendViewController{
    private func loadData(){
        recommendVM.requestData {
            self.colloectionView.reloadData()
        }
    }
    
    
    
}
extension RecommendViewController{
    private func setupUI(){
        view.addSubview(colloectionView)
    
    }
}
extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroup.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       let group = recommendVM.anchorGroup[section]
        return group.anchors.count
        
        //        if section == 0 {
//            return 8
//        }else{
//            return 4
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = recommendVM.anchorGroup[indexPath.section]
        let anchor = group.anchors[indexPath.item]
      
        if(indexPath.section == 1){
         let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            cell.anchor = anchor
            return cell
            
        }else{
          let   cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
              cell.anchor = anchor
            return cell
        }
        
        
       // return nil
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headView = colloectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeardViewhID, for: indexPath) as! CollectionHeadView
       // headView.backgroundColor = UIColor.green
        let group = recommendVM.anchorGroup[indexPath.section]
        headView.group = group
        
        return headView
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if(indexPath.section == 1){
            return CGSize(width: kItemW, height: kPrettyItemH)
        }else{
            return CGSize(width: kItemW, height: kNormalItemH)
        }
    }
    
    
}
