//
//  VerifyOldPhoneViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/19.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
enum GetCodeType:String{
    case regist = "1"
    case forgetPwd = "2"
    case verifyOldPwd = "3"
    case updatePhoneAndBindPhone = "4"
}
class VerifyOldPhoneViewController: BaseViewController {

    var dataController:VerifyOldPhoneDataController!
    var updatePhoneBlock:UpdatePhoneBlock?
    
    @IBOutlet var phoneTextField: BaseTextField!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var bgView1: UIView!
    @IBOutlet var bgView2: UIView!
    
    @IBOutlet var codeTextField: BaseTextField!
    @IBOutlet var getCodeButton: UIButton!
    @IBAction func getCodeClick(_ sender: UIButton) {
        if !checkPhone(){
            return
        }
       loadGetVercode()
    }
 
    @IBAction func nextBtnClick(_ sender: Any) {
        if !checkPhone(){
            return
        }
        if !checkCode(){
            return
        }
        loadCheckUserVerCode()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "验证旧手机号"
        initData()
        initUI()
    }
}
//MARK:-Private
extension VerifyOldPhoneViewController{
    fileprivate func initUI(){
        bgView1.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
        bgView2.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor

    }
    fileprivate func initData(){
        dataController = VerifyOldPhoneDataController(delegate: self)
        updatePhoneBlock = senderParam as? UpdatePhoneBlock
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
            "type":GetCodeType.verifyOldPwd.rawValue
        ]
        dataController.getVerCode(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                let countDown = TCCountDown()//实例化
                countDown.getCodeButton = self.getCodeButton
                countDown.isCounting = true//开启倒计时
            }else {
            }
        }
    }
    //验证原绑定手机验证码
    fileprivate func loadCheckUserVerCode(){
        let parameter:NSMutableDictionary = [
            "phone":phoneTextField.text!,
            "verCode":codeTextField.text!
        ]
        dataController.checkUserVerCode(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                let dic:NSMutableDictionary = [
                    "block":self.updatePhoneBlock,
                    "oldPhone":self.phoneTextField.text!,
                    "oldPhoneVerCode":self.codeTextField.text!,
                ]
              self.pushViewController("UpdatePhoneViewController",sender:dic)
            }else {
            }
        }
    }
}
