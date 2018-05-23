//
//  SelectMultipleStudentTableViewCell.swift
//  MiddleSchool2_teacher
//
//  Created by 王岩 on 2017/6/1.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

class SelectMultipleStudentTableViewCell: UITableViewCell {
    
    var model:SelectMultipleStudentModel = SelectMultipleStudentModel()
   
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var selectButton: UIButton!
    
    func update(student:SelectMultipleStudentModel){
        model = student
        if String.isNilOrEmpty(student.studentNo){
            nameLabel.text = student.name
        }
        else{
            nameLabel.text = "\(student.name)(\(student.studentNo))"
        }
        selectButton.isSelected = model.isSelected
    }
    
  

    class func loadCell(_ tableView:UITableView)-> SelectMultipleStudentTableViewCell{
        let cellId:String = "SelectMultipleStudentTableViewCellId"
        var cell:SelectMultipleStudentTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? SelectMultipleStudentTableViewCell
        
        if (cell == nil || !cell!.isKind(of: SelectMultipleStudentTableViewCell.self)){
            cell = SelectMultipleStudentTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }

}
