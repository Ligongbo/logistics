//
//  MineSchoolTableViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class MineSchoolTableViewCell: UITableViewCell {

    @IBOutlet weak var aboutUsLabel: UILabel!
    
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var lineLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func update(model:MyAccountModel,type:String){
        aboutUsLabel.text?.removeAll()
        if type == "1"{
            titleLabel.text = "学校"
            contentLabel.text = model.schoolName
        }else if type == "2"{
            titleLabel.text = "修改密码"
            contentLabel.text = "定期修改密码账户更安全"
        }else if type == "3"{
            titleLabel.text = "修改手机号"
            contentLabel.text = model.phone
        }else if type == "4"{
            titleLabel.text = "清理缓存"
            contentLabel.text = "点击可以释放更多空间"
           
        }else if type == "5"{
            aboutUsLabel.text = "关于我们"
            titleLabel.text?.removeAll()
            contentLabel.text?.removeAll()
            lineLabel.isHidden = true
        }else if type == "6"{
            titleLabel.text = "子女"
            contentLabel.text = model.stuName
        }
    }

    class func loadCell(_ tableView:UITableView)-> MineSchoolTableViewCell{
        let cellId:String = "MineSchoolTableViewCellId"
        var cell:MineSchoolTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? MineSchoolTableViewCell
        
        if (cell == nil || !cell!.isKind(of: MineSchoolTableViewCell.self)){
            cell = MineSchoolTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    
}
