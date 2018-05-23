//
//  MineAddStudentViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/4.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class MineAddStudentViewController: BaseViewController {

    @IBOutlet var passwordTextField: BaseTextField!
    @IBOutlet var parentAccountTextField: BaseTextField!
    var block:AddStudentBlock?
    @IBOutlet var bgView2: UIView!
    @IBOutlet var bgView1: UIView!
    var dataController:MineAddStudentDataController!
    
    @IBAction func finishClick(_ sender: Any) {
        loadStudentList()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "添加子女"
        initData()
        initUI()
        
    }
    //获取子女列表
    func loadStudentList(){
        if checkFun(){
            let parameter:NSMutableDictionary = [
                "parentAccount":parentAccountTextField.text!,
                "pwd":passwordTextField.text!,
                "userId":currentUser.userId,
                ]
            dataController.getStuListByAccount(parameter: parameter) { (isSucceed, info) in
                if isSucceed {
                    
                    let dic:NSMutableDictionary = [
                        "block":self.block,
                        "stuArray":self.dataController.model.data.studentList,
                        "bindUserId":self.dataController.model.data.userId
                    ]
                    self.pushViewController("MineSelectStudentMultipleViewController",sender:dic)
                }else {
                }
            }
        }
    }

}
//MARK: - Private
extension MineAddStudentViewController{
    fileprivate func initUI(){
        bgView1.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
        bgView2.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
        
    }
    fileprivate func initData(){
        dataController = MineAddStudentDataController(delegate: self)
        if senderParam != nil {
            block = senderParam as! AddStudentBlock
        }
    }
    fileprivate func checkFun() -> Bool{
        if String.isNilOrEmpty(parentAccountTextField.text){
            LHAlertView.showTipAlertWithTitle("网页端用户名不能为空")
            return false
        }
        if String.isNilOrEmpty(passwordTextField.text){
            LHAlertView.showTipAlertWithTitle("网页端密码不能为空")
            return false
        }
        return true
    }
}
