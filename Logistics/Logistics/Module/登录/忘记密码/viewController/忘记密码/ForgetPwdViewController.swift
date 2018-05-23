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

    var isStudent = false//false不是学生
    @IBAction func switchChange(_ sender: UISwitch) {
        if sender.isOn {
            phoneTextField.placeholder = "请输入家长用户绑定的手机号"
            isStudent = true
            studentAccount.isEnabled = true
        }else{
            phoneTextField.placeholder = "请输入绑定的手机号"
            isStudent = false
            studentAccount.isEnabled = false
            studentAccount.text = ""
        }
    }
    @IBOutlet var codeTextField: BaseTextField!
    @IBOutlet weak var phoneTextField: BaseTextField!
    var dataController:ForgetPwdDataController!
    
//    @IBAction func isAgreeClick(_ sender: UIButton) {
//        let img = UIImage.init(named: "main_MutiCheck_Off")
//        if sender.currentBackgroundImage == img{
//            isAgree = true
//            sender.setBackgroundImage(UIImage.init(named: "main_MutiCheck_On"), for: .normal)
//        }else {
//            isAgree = false
//            sender.setBackgroundImage(UIImage.init(named: "main_MutiCheck_Off"), for: .normal)
//        }
//        
//    }
//    var isAgree = false //是否同意
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var bgView1: UIView!
     @IBOutlet var bgView2: UIView!
     @IBOutlet var bgView3: UIView!
    @IBOutlet var getCodeButton: UIButton!
    @IBAction func getCodeClick(_ sender: UIButton) {
        closeKeyboard()
        if !checkPhone(){
            return
        }
        loadGetVercode()
    }
//    @IBAction func protocolClick(_ sender: Any) {
//        let webVc = CommonWebViewController()
//        webVc.urlContent = Protocolhtml
//        webVc.titleContent = "用户协议及隐私政策"
//        self.navigationController?.pushViewController(webVc, animated: true)
//    }
    @IBAction func nextBtnClick(_ sender: Any) {
        closeKeyboard()
//        if !isAgree {
//            LHAlertView.showTipAlertWithTitle("请同意用户协议隐私政策")
//        }else{
            if !checkPhone(){
                return
            }
            if !checkCode(){
                return
            }
            if isStudent{
                if String.isNilOrEmpty(studentAccount.text){
                    LHAlertView.showTipAlertWithTitle("请输入学生账号")
                    return
                }
            }
            commonCheckVerCodeByFindPwd()
//        }
        
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
        bgView1.layer.cornerRadius = 5
        bgView1.layer.borderWidth = 1
        bgView1.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
        bgView2.layer.cornerRadius = 5
        bgView2.layer.borderWidth = 1
        bgView2.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
        bgView3.layer.cornerRadius = 5
        bgView3.layer.borderWidth = 1
        bgView3.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
        nextBtn.layer.cornerRadius = 5
        getCodeButton.layer.cornerRadius = 5
    }
    fileprivate func initData(){
        dataController = ForgetPwdDataController(delegate: self)
    }
    fileprivate func checkPhone() -> Bool{
        if !(phoneTextField.text?.isLegalMobile())!{
            return false
        }
        return true
    }
    fileprivate func checkCode() -> Bool{
        if String.isNilOrEmpty(codeTextField.text){
            LHAlertView.showTipAlertWithTitle("验证码不能为空")
            return false
        }
        return true
    }
    //获取验证码
    fileprivate func loadGetVercode(){
        
        let parameter:NSMutableDictionary = [
            "phone":phoneTextField.text!,
            "type":GetCodeType.forgetPwd.rawValue
        ]
        dataController.getVerCode(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                LHAlertView.showTipAlertWithTitle(info as! String)
                let countDown = TCCountDown()//实例化
                countDown.getCodeButton = self.getCodeButton
                countDown.isCounting = true//开启倒计时
            }else {
            }
        }
    }

    //账号绑定校验验证码
    fileprivate func commonCheckVerCodeByFindPwd(){
        let parameter:NSMutableDictionary = [
            "phone":phoneTextField.text!,
            "verCode":codeTextField.text!,
            "stuUserName":isStudent == false ? "": studentAccount.text!
        ]
        dataController.commonCheckVerCodeByFindPwd(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                let dic:NSMutableDictionary = [
                    "phone":self.phoneTextField.text!,
                    "verCode":self.codeTextField.text!,
                    "stuUserName":self.isStudent == false ? "": self.studentAccount.text!
                ]
                self.pushViewController("SettingNewPasswordViewController",sender:dic)
            }else {
            }
        }
    }
}
