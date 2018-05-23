//
//  MineLogoutTableViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class MineLogoutTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    class func loadCell(_ tableView:UITableView)-> MineLogoutTableViewCell{
        let cellId:String = "MineLogoutTableViewCellId"
        var cell:MineLogoutTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? MineLogoutTableViewCell
        
        if (cell == nil || !cell!.isKind(of: MineLogoutTableViewCell.self)){
            cell = MineLogoutTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
}
