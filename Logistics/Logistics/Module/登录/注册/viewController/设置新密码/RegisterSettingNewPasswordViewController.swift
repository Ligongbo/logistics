//
//  RegisterSettingNewPasswordViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class RegisterSettingNewPasswordViewController: BaseViewController,UITextFieldDelegate {

    
    @IBOutlet var oldPassWordTextField: BaseTextField!
    @IBOutlet var newPasswordTextField: BaseTextField!
    @IBOutlet var bgView2: UIView!
    @IBOutlet var bgView1: UIView!
    var phone = ""
    var verCode = ""
    @IBAction func finishClick(_ sender: Any) {
        closeKeyboard()
        if !checkFun(){
            return
        }
        let dic:NSMutableDictionary = [
            "phone":phone,
            "verCode":verCode,
            "password":newPasswordTextField.text!
        ]
        pushViewController("BindAccountViewController",sender:dic)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置新密码"
        initData()
        initUI()
    }

}
//MARK: - Private
extension RegisterSettingNewPasswordViewController{
    fileprivate func initUI(){
        bgView1.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
        bgView2.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
        oldPassWordTextField.delegate = self
        newPasswordTextField.delegate = self
        
    }
    fileprivate func initData(){
        if senderParam != nil {
            let dic = senderParam as! NSMutableDictionary
            if dic["phone"] != nil {
                phone = dic["phone"] as! String
            }
            if dic["verCode"] != nil {
                verCode = dic["verCode"] as! String
            }
        }
    }
    fileprivate func checkFun()->Bool{
        if String.isNilOrEmpty(oldPassWordTextField.text){
            LHAlertView.showTipAlertWithTitle("密码不能为空")
            return false
        }
        if String.isNilOrEmpty(newPasswordTextField.text){
            LHAlertView.showTipAlertWithTitle("确认密码不能为空")
            return false
        }
        if oldPassWordTextField.text != newPasswordTextField.text{
            LHAlertView.showTipAlertWithTitle("两次密码需要一致")
            return false
        }
        if !(newPasswordTextField.text?.isLegalPassword())!{
            return false
        }
        if (newPasswordTextField.text!).characters.count > 20{
            LHAlertView.showTipAlertWithTitle("请确保密码长度小于20")
            
            return false
        }
        if (newPasswordTextField.text! as! String).characters.count < 6{
            LHAlertView.showTipAlertWithTitle("请确保密码长度大于6")
            
            return false
        }
        return true
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.isNumOrString()
    }
}
