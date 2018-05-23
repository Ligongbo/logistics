//
//  ChangeAreaCollectionViewCell.swift
//  HandleSchool
//
//  Created by LiGongbo on 2017/12/19.
//  Copyright © 2017年 Huihai. All rights reserved.
//

import UIKit

class ChangeAreaCollectionViewCell: UICollectionViewCell {

    @IBOutlet var backView: UIView!
    @IBOutlet var addressNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.setCornerWithRadius(12)

    }

    func update(model:BaseAreaListModel){
        addressNameLabel.text = model.name
        if model.isSelected {
            backView.backgroundColor = UIColor.init(hexString: "198cf9")
            addressNameLabel.textColor = UIColor.white
        }else {
            backView.backgroundColor = UIColor.init(hexString: "f4f4f4")
            addressNameLabel.textColor = UIColor.black
        }
        
    }
}
