//
//  BindAccountShowStudentsTableViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/7.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class BindAccountShowStudentsTableViewCell: UITableViewCell {

    @IBOutlet weak var gradeClassNameLabel: UILabel!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headPhotoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
    }
    //注册时
    func update(model:BindAccountStudentModel){
        headPhotoImageView.sd_setImage(with: URL.init(string: FileAccessHost + model.headUrl))
        gradeClassNameLabel.text = model.gradeClassName
        schoolNameLabel.text = model.schoolName
        nameLabel.text = model.name
    }

    //我的添加子女的时候
    func update(model:StudentItemModel){
        headPhotoImageView.sd_setImage(with: URL.init(string: FileAccessHost + model.headUrl))
        gradeClassNameLabel.text = model.gradeClassName
        schoolNameLabel.text = model.schoolName
        nameLabel.text = model.name
    }
    class func loadCell(_ tableView:UITableView)-> BindAccountShowStudentsTableViewCell{
        let cellId:String = "BindAccountShowStudentsTableViewCellId"
        var cell:BindAccountShowStudentsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? BindAccountShowStudentsTableViewCell
        
        if (cell == nil || !cell!.isKind(of: BindAccountShowStudentsTableViewCell.self)){
            cell = BindAccountShowStudentsTableViewCell()
        }
        cell!.selectionStyle = .none
        return cell!
    }
    
}
