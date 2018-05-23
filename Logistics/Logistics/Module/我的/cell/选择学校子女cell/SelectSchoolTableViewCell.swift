//
//  SelectSchoolTableViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/19.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class SelectSchoolTableViewCell: UITableViewCell {

    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var lineLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
    }

    class func loadCell(_ tableView:UITableView)-> SelectSchoolTableViewCell{
        let cellId:String = "SelectSchoolTableViewCellId"
        var cell:SelectSchoolTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? SelectSchoolTableViewCell
        
        if (cell == nil || !cell!.isKind(of: SelectSchoolTableViewCell.self)){
            cell = SelectSchoolTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
}
