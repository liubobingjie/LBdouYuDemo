//
//  CollectionNormalCell.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/12.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {
    
    @IBOutlet weak var roomLabel: UILabel!
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
            
            
            iconImageView.kf.setImage(with: URL(string:anchor.vertical_src))
            
            roomLabel.text = anchor.room_name
            
            
        }
    }
   

}
