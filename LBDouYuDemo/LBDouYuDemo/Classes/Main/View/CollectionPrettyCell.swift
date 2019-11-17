//
//  CollectionPrettyCell.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/15.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: UICollectionViewCell {
    
    @IBOutlet weak var cityBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var onlineBtn: UIButton!
    var anchor:AnchorModel?{
        didSet{
            guard let anchor = anchor else {return}
            var onLineStr:String = ""
            if (anchor.online >= 10000 ){
             onLineStr = "\(anchor.online/10000)万在线"
            }else{
                onLineStr = "\(anchor.online)万在线"
            }
            onlineBtn.setTitle(onLineStr, for: UIControl.State.normal)
            
            nickNameLabel.text = anchor.nickname
            cityBtn.setTitle(anchor.anchor_city, for: UIControl.State.normal)
            
            iconImageView.kf.setImage(with: URL(string:anchor.vertical_src))
            
            
    }

   
}
}
