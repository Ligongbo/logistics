//
//  MineHeadPhotoTableViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class MineHeadPhotoTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var headImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
    }

    func update(model:MyAccountModel){

    headImageView.sd_setImage(with: URL.init(string: FileAccessHost + model.headUrl), placeholderImage: UIImage.loadImage("image-placeholder"), options: .retryFailed, progress: nil, completed: nil)
 
        nameLabel.text = model.name
    }
    
    class func loadCell(_ tableView:UITableView)-> MineHeadPhotoTableViewCell{
        let cellId:String = "MineHeadPhotoTableViewCellId"
        var cell:MineHeadPhotoTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? MineHeadPhotoTableViewCell
        
        if (cell == nil || !cell!.isKind(of: MineHeadPhotoTableViewCell.self)){
            cell = MineHeadPhotoTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
}
