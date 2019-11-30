//
//  CollectionGameCell.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/23.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLab: UILabel!
    
    // MARK: 定义模型属性
    var baseGame : BaseGameModel? {
        didSet {
            titleLab.text = baseGame?.tag_name
            
            if let iconURL = URL(string: baseGame?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconURL)
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.layer.cornerRadius = iconImageView.frame.size.height / 2
        iconImageView.layer.masksToBounds = true
    }
    
    

}
