//
//  BindAccountViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/7.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit



class BindAccountViewController: BaseViewController {

    @IBOutlet weak var webAccount: BaseTextField!
    @IBOutlet weak var webPassword: BaseTextField!
    @IBOutlet var bgView1: UIView!
    @IBOutlet var bgView2: UIView!
    var dataController:BindAccountDataController!
    @IBAction func finishBtnClick(_ sender: Any) {
        closeKeyboard()
        if checkFun(){
            getSchOrStuListByUser()
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "绑定账号"
        initData()
        initUI()
    }

    
}
extension BindAccountViewController{
    fileprivate func initUI(){
        bgView1.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
        bgView2.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
    }
    fileprivate func initData(){
        dataController = BindAccountDataController(delegate: self)
        if senderParam != nil {
            dataController.update(dic: senderParam as! NSMutableDictionary)
        }
        
    }
    //根据用户名密码获取（教师学校列表、家长学生列表）
    fileprivate func getSchOrStuListByUser(){
        
        let parameter:NSMutableDictionary = [
            "parentAccount":webAccount.text!,
            "pwd":webPassword.text!
        ]
        dataController.getSchOrStuListByUser(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.dataController.model.data.phone = self.dataController.phone
                self.dataController.model.data.verCode = self.dataController.verCode
              
                self.dataController.model.data.pwd = self.dataController.password//把设置的新密码传过去
                self.pushViewController("BindAccountShowStudentOrSchoolViewController", sender: self.dataController.model.data)
            }else {
            }
        }
    }
    fileprivate func checkFun() -> Bool{
        if String.isNilOrEmpty(webAccount.text){
            LHAlertView.showTipAlertWithTitle("网页端用户名不能为空")
            return false
        }
        if String.isNilOrEmpty(webPassword.text){
            LHAlertView.showTipAlertWithTitle("网页端密码不能为空")
            return false
        }
        return true
    }
    
}
