//
//  CollectionHeadView.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/12.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionHeadView: UICollectionReusableView {

    @IBOutlet weak var iconImageName: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    var group:AnchorGroupModel?{
        didSet{
            titlelabel.text = group?.tag_name
            
               iconImageName.image = UIImage(named: group?.icon_name ?? "home_header_hot")
            
            
           
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
