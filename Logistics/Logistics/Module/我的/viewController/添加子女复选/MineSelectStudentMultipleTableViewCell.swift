//
//  MineSelectStudentMultipleTableViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/4.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class MineSelectStudentMultipleTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var selectButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//    func update(model:StudentListModel){
//        if String.isNilOrEmpty(model.studentNo){
//            nameLabel.text = model.name
//        }
//        else{
//            nameLabel.text = "\(model.name)(\(model.studentNo))"
//        }
//        selectButton.isSelected = model.isSelected
//    }

    class func loadCell(_ tableView:UITableView)-> MineSelectStudentMultipleTableViewCell{
        let cellId:String = "MineSelectStudentMultipleTableViewCellId"
        var cell:MineSelectStudentMultipleTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? MineSelectStudentMultipleTableViewCell
        
        if (cell == nil || !cell!.isKind(of: MineSelectStudentMultipleTableViewCell.self)){
            cell = MineSelectStudentMultipleTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
}
