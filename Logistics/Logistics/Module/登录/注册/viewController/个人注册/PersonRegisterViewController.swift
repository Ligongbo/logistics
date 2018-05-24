//
//  PersonRegisterViewController.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/23.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class PersonRegisterViewController: BaseViewController {
    @IBOutlet weak var companyAccountView: UIView!
    
    var timer:Timer!
    //密码
    @IBOutlet weak var passwordTextField: UITextField!
    //用户名
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet var codeTextField: UITextField!
    //企业网号
    @IBOutlet var companyAccountTextField: UITextField!
    var dataController:PersonRegisterDataController!
    var saveView:CodeSuccessView?
    @IBOutlet var getCodeButton: UIButton!
    
    @IBAction func getCodeClick(_ sender: UIButton) {
        closeKeyboard()
        
        loadGetVercode()
    }
    @IBAction func nextBtnClick(_ sender: Any) {
        closeKeyboard()
        
        if !checkPhone(){
            return
        }
        commonCheckVerCodeByFindPwd()
        
        
    }
    @IBAction func loginBtnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "账号注册"
        initData()
        initUI()
    }

   

}
extension PersonRegisterViewController{
    fileprivate func initUI(){
        
        
    }
    fileprivate func initData(){
        dataController = PersonRegisterDataController(delegate: self)
        if senderParam != nil {
            dataController.type = senderParam as! String
            if dataController.type == "company"{
                companyAccountView.removeAllSubviews()
                companyAccountView.removeFromSuperview()
            }
        }
        
    }
}
extension PersonRegisterViewController{
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
    }
    
    fileprivate func checkPhone() -> Bool{
//        if !(userNameTextField.text?.isLegalMobile())!{
//            return false
//        }
        return true
    }
    //账号绑定校验验证码
    fileprivate func commonCheckVerCodeByFindPwd(){
        let dic:NSMutableDictionary = [
            "phone":userNameTextField.text
        ]
        self.pushViewController("PersonMessageViewController",sender:dic)
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
