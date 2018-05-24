//
//  PersonMessagePhotoTableViewCell.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/23.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class PersonMessagePhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var selectImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func loadCell(_ tableView:UITableView)-> PersonMessagePhotoTableViewCell{
        let cellId:String = "PersonMessagePhotoTableViewCellId"
        var cell:PersonMessagePhotoTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? PersonMessagePhotoTableViewCell
        
        if (cell == nil || !cell!.isKind(of: PersonMessagePhotoTableViewCell.self)){
            cell = PersonMessagePhotoTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
    
}
