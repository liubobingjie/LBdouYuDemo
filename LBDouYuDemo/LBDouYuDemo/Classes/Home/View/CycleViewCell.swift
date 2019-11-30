//
//  CycleViewCell.swift
//  LBDouYuDemo
//
//  Created by mc on 2019/11/23.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Kingfisher

class CycleViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var cycleModel:CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            iconImageView.kf.setImage(with: URL(string: (cycleModel?.pic_url ?? "")))
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
