//
//  MyCell.swift
//  collectionViewDemo
//
//  Created by 王岩 on 2017/8/2.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
typealias DeleteBlock = () -> Void
class MyCell: UICollectionViewCell {

    @IBOutlet var deleteBtn: UIButton!
    @IBAction func deleteClick(_ sender: Any) {
        deleteBlock?()
    }
    @IBOutlet var testImage: UIImageView!
    var deleteBlock:DeleteBlock?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
