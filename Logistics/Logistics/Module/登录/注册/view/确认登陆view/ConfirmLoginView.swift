//
//  ConfirmLoginView.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/8.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

typealias BindAccountLoginBlock = (_ id:String) ->Void
class ConfirmLoginView: UIView {
    
    @IBOutlet var tableView: UITableView!

    var isFlag = false//是否勾选了学生或者学校
    
    var cellCount = 0
    
    var model:BindAccountModel!
    var bindAccountLoginBlock:BindAccountLoginBlock!
    @IBAction func loginBtnClick(_ sender: Any) {
        if model.userType == .parent{
            for item in model.studentList{
                if item.isSelected == "0"{
                    isFlag = false
                }else if item.isSelected == "1"{
                    isFlag = true
                    self.hideInWindow()
                    bindAccountLoginBlock(item.id)
                    return
                }
            }
            if !isFlag{
                LHAlertView.showTipAlertWithTitle("请选择子女")
            }
        }else if model.userType == .teacher{
            for item in model.schoolList{
                if item.isSelected == "0"{
                    isFlag = false
                }else if item.isSelected == "1"{
                    isFlag = true
                    self.hideInWindow()
                    bindAccountLoginBlock(item.schoolId)
                    return
                }
            }
            if !isFlag{
                LHAlertView.showTipAlertWithTitle("请选择学校")
            }
        }
        
        
        
        
    }
    func update(dic:NSMutableDictionary){
        if dic["model"] != nil {
            self.model = dic["model"] as! BindAccountModel
        }
        if dic["block"] != nil {
            self.bindAccountLoginBlock = dic["block"] as! BindAccountLoginBlock
        }
        if model.userType == .parent{
            cellCount = 1 + self.model.studentList.count
            //默认选中第一条
            if self.model.studentList.count > 0{
                self.model.studentList[0].isSelected = "1"
            }
        }else if model.userType == .teacher{
            cellCount = 1 + self.model.schoolList.count
            //默认选中第一条
            if self.model.schoolList.count > 0{
                self.model.schoolList[0].isSelected = "1"
            }
        }

        initUI()
    }
    fileprivate func initUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register("ConfirmLoginPwdTableViewCell")
        tableView.register("ConfirmLoginSelectStrOrSchoolTableViewCell")
        
    }
}
extension ConfirmLoginView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = ConfirmLoginPwdTableViewCell.loadCell(tableView)
            if model.userType == .parent{
                cell.studentOrSchoolLabel.text = "选择子女"
            }else{
                cell.studentOrSchoolLabel.text = "选择学校"
            }
            cell.update(model: self.model)
            return cell
            
        }else{
            let cell = ConfirmLoginSelectStrOrSchoolTableViewCell.loadCell(tableView)
            if model.userType == .parent{
                cell.updateParent(model: model.studentList[indexPath.row - 1])
                
            }else if model.userType == .teacher{
                cell.updateTeacher(model: model.schoolList[indexPath.row - 1])
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0{
            if model.userType == .parent{
                if model.studentList[indexPath.row - 1].isSelected == "0"{
                    model.studentList[indexPath.row - 1].isSelected = "1"
                }else{
                    model.studentList[indexPath.row - 1].isSelected = "0"
                }
                
            }else if model.userType == .teacher{
               
                if model.schoolList[indexPath.row - 1].isSelected == "0"{
                    model.schoolList[indexPath.row - 1].isSelected = "1"
                }else{
                    model.schoolList[indexPath.row - 1].isSelected = "0"
                }
                //单选把其余的制成false
                for i in 0..<model.schoolList.count{
                    if indexPath.row - 1 != i{
                        model.schoolList[i].isSelected = "0"
                    }
                }

            }
            self.tableView.reloadData()
        }
    }
}
