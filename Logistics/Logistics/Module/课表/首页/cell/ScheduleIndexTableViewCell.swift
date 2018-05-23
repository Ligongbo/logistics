//
//  ScheduleIndexTableViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/8.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class ScheduleIndexTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var gradeClassLabel: UILabel!

    func updateTeacher(model:ScheduleTeacherModel){
        sectionLabel.text = model.section
        gradeClassLabel.text = model.gradeClass
    }
    func updateStudent(model:ScheduleTeacherModel){
        sectionLabel.text = model.section
        gradeClassLabel.text = model.teaName
    }
 
    class func loadCell(_ tableView:UITableView)-> ScheduleIndexTableViewCell{
        let cellId:String = "ScheduleIndexTableViewCellId"
        var cell:ScheduleIndexTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? ScheduleIndexTableViewCell
        
        if (cell == nil || !cell!.isKind(of: ScheduleIndexTableViewCell.self)){
            cell = ScheduleIndexTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
}
