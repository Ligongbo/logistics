//
//  SettingNewPasswordViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class SettingNewPasswordViewController: BaseViewController {

@IBOutlet var codeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var timer:Timer!
    var saveView:CodeSuccessView?
    @IBOutlet var getCodeButton: UIButton!
    @IBAction func getCodeClick(_ sender: UIButton) {
        closeKeyboard()
       
        loadGetVercode()
    }
    @IBAction func isShowPasswordBtn(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    var dataController:SettingNewPasswordDataController!
    @IBAction func finishClick(_ sender: Any) {
        if checkFun() {
            authFindPwd()
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "重置密码"
        initData()
        initUI()
    }

   

}
//MARK: - Private
extension SettingNewPasswordViewController{
    fileprivate func initUI(){
       

    }
    fileprivate func initData(){
        dataController = SettingNewPasswordDataController(delegate: self)
       
    }
    //找回密码
    fileprivate func authFindPwd(){
        pushViewController("AutoLoginViewController")
//        let parameter:NSMutableDictionary = [
////            "phone":phone,
////            "verCode":verCode,
//            "newPwd":passwordTextField.text,
////            "stuUserName":stuUserName
//        ]
//        self.dataController.authFindPwd(parameter: parameter) { (isSucceed, info) in
//            if isSucceed {
//                let controllers = self.navigationController?.childViewControllers
//                for vc in controllers!{
//                    if vc is LoginViewController{
//                        self.navigationController?.popToViewController(vc, animated: true)
//                    }
//                }
//            }else {
//            }
//        }
    }
    fileprivate func checkFun()->Bool{
        if String.isNilOrEmpty(codeTextField.text){
            LHAlertView.showTipAlertWithTitle("验证码不能为空")
            return false
        }
        
        if String.isNilOrEmpty(passwordTextField.text){
            LHAlertView.showTipAlertWithTitle("密码不能为空")
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
    
    fileprivate func loadGetVercode(){
//        self.showCodeSuccess()
        let parameter:NSMutableDictionary = [
//            "phone":phoneTextField.text!,
            "type":GetCodeType.forgetPwd.rawValue
        ]
        dataController.getVerCode(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                LHAlertView.showTipAlertWithTitle(info as! String)
                let countDown = TCCountDown()//实例化
                countDown.getCodeButton = self.getCodeButton
                countDown.isCounting = true//开启倒计时
            }else {
                print("验证码失败")

                let countDown = TCCountDown()//实例化
                countDown.getCodeButton = self.getCodeButton
                countDown.isCounting = true//开启倒计时
                self.showCodeSuccess()
            }
        }
    }
    
    func showCodeSuccess(){
        saveView = UIView.loadViewWithName("CodeSuccessView") as? CodeSuccessView
        
        saveView?.frame = CGRect(x: 0, y: 0, width: 200, height: 160 )
        saveView?.clipsToBounds = true
        saveView?.layer.cornerRadius = 5
        saveView?.showInWindow()
        // 启用计时器，控制每秒执行一次tickDown方法
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(codeTipDismiss), userInfo: nil, repeats: false)
    }
    @objc func codeTipDismiss(){
        saveView?.hide()
        timer.invalidate()
    }

}
