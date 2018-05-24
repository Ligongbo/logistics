//
//  CompanyRegisterPhotoTableViewCell.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/24.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class CompanyRegisterPhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var mustImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func loadCell(_ tableView:UITableView)-> CompanyRegisterPhotoTableViewCell{
        let cellId:String = "CompanyRegisterPhotoTableViewCellId"
        var cell:CompanyRegisterPhotoTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? CompanyRegisterPhotoTableViewCell
        
        if (cell == nil || !cell!.isKind(of: CompanyRegisterPhotoTableViewCell.self)){
            cell = CompanyRegisterPhotoTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
