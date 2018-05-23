//
//  ForgetPwdViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/17.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class ForgetPwdViewController: BaseViewController {
    @IBOutlet weak var studentAccount: BaseTextField!

  
    
    @IBOutlet weak var phoneTextField: UITextField!
    var dataController:ForgetPwdDataController!
    

    
    @IBAction func nextBtnClick(_ sender: Any) {
        closeKeyboard()

            if !checkPhone(){
                return
            }
        commonCheckVerCodeByFindPwd()
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "忘记密码"
        initData()
        initUI()
        
    }
    
}
extension ForgetPwdViewController{
    fileprivate func initUI(){
      
    }
    fileprivate func initData(){
        dataController = ForgetPwdDataController(delegate: self)
    }
    fileprivate func checkPhone() -> Bool{
//        if !(phoneTextField.text?.isLegalMobile())!{
//            return false
//        }
        return true
    }
   

    //账号绑定校验验证码
    fileprivate func commonCheckVerCodeByFindPwd(){
        self.pushViewController("SettingNewPasswordViewController")
//        let parameter:NSMutableDictionary = [
//            "phone":phoneTextField.text!,
//
//
//        ]
//        dataController.commonCheckVerCodeByFindPwd(parameter: parameter) { (isSucceed, info) in
//            if isSucceed {
//                let dic:NSMutableDictionary = [
//                    "phone":self.phoneTextField.text!,
//
//
//                ]
//                self.pushViewController("SettingNewPasswordViewController",sender:dic)
//            }else {
//            }
//        }
    }
}
