//
//  SettingNewPasswordViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class SettingNewPasswordViewController: BaseViewController {

    @IBOutlet weak var confirmPasswordTextField: BaseTextField!
    @IBOutlet weak var passwordTextField: BaseTextField!
    @IBOutlet var bgView2: UIView!
    @IBOutlet var bgView1: UIView!
    var phone = ""
    var verCode = ""
    var stuUserName = ""
    var dataController:SettingNewPasswordDataController!
    @IBAction func finishClick(_ sender: Any) {
        if checkFun() {
            authFindPwd()
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置新密码"
        initData()
        initUI()
    }

   

}
//MARK: - Private
extension SettingNewPasswordViewController{
    fileprivate func initUI(){
        bgView1.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
        bgView2.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor

    }
    fileprivate func initData(){
        dataController = SettingNewPasswordDataController(delegate: self)
        if senderParam != nil {
            let dic = senderParam as! NSMutableDictionary
            if dic["phone"] != nil {
                phone = dic["phone"] as! String
            }
            if dic["verCode"] != nil {
                verCode = dic["verCode"] as! String
            }
            if dic["stuUserName"] != nil {
                stuUserName = dic["stuUserName"] as! String
            }
            
        }
    }
    //找回密码
    fileprivate func authFindPwd(){
        
        let parameter:NSMutableDictionary = [
            "phone":phone,
            "verCode":verCode,
            "newPwd":passwordTextField.text,
            "stuUserName":stuUserName
        ]
        self.dataController.authFindPwd(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                let controllers = self.navigationController?.childViewControllers
                for vc in controllers!{
                    if vc is LoginViewController{
                        self.navigationController?.popToViewController(vc, animated: true)
                    }
                }
            }else {
            }
        }
    }
    fileprivate func checkFun()->Bool{
        if String.isNilOrEmpty(passwordTextField.text){
            LHAlertView.showTipAlertWithTitle("密码不能为空")
            return false
        }
        if String.isNilOrEmpty(confirmPasswordTextField.text){
            LHAlertView.showTipAlertWithTitle("确认密码不能为空")
            return false
        }
        if passwordTextField.text != confirmPasswordTextField.text{
            LHAlertView.showTipAlertWithTitle("两次密码需要一致")
            return false
        }
        if !(confirmPasswordTextField.text?.isLegalPassword())!{
            return false
        }
        if (confirmPasswordTextField.text!).characters.count > 20{
            LHAlertView.showTipAlertWithTitle("请确保密码长度小于20")
            
            return false
        }
        if (confirmPasswordTextField.text! as! String).characters.count < 6{
            LHAlertView.showTipAlertWithTitle("请确保密码长度大于6")
            
            return false
        }
        return true
        
    }

}
