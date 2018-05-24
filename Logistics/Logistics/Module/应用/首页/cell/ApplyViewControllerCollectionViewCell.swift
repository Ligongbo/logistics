//
//  ApplyViewControllerCollectionViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/17.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class ApplyViewControllerCollectionViewCell: UICollectionViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        // Initialization code
    }
    func update(model:ApplyToolModel){
//        nameLabel.text = model.text
//        iconImageView.sd_setImage(with: URL.init(string: BaseImgUrl + model.icon))
    }

}
