//
//  ParentRegisterViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class ParentRegisterViewController: BaseViewController {

    var dataController:ParentRegisterDataController!
    @IBOutlet var codeTextField: BaseTextField!
    @IBOutlet weak var phoneTextField: BaseTextField!
    @IBAction func isAgreeClick(_ sender: UIButton) {
        let img = UIImage.init(named: "main_MutiCheck_Off")
        if sender.currentBackgroundImage == img{
            isAgree = true
            sender.setBackgroundImage(UIImage.init(named: "main_MutiCheck_On"), for: .normal)
        }else {
            isAgree = false
            sender.setBackgroundImage(UIImage.init(named: "main_MutiCheck_Off"), for: .normal)
        }
        
    }
    var isAgree = true //是否同意
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var bgView1: UIView!
    @IBOutlet var bgView2: UIView!

    @IBOutlet var getCodeButton: UIButton!
    @IBAction func getCodeClick(_ sender: UIButton) {
        closeKeyboard()
        if !checkPhone(){
            return
        }
        loadGetVercode()

        
    }
    @IBAction func protocolClick(_ sender: Any) {
      
        let webVc = CommonWebViewController()
        webVc.urlContent = Protocolhtml
        webVc.titleContent = "用户协议及隐私政策"
        self.navigationController?.pushViewController(webVc, animated: true)

    }
    @IBAction func nextBtnClick(_ sender: Any) {
        closeKeyboard()
        if !isAgree {
            LHAlertView.showTipAlertWithTitle("请同意用户协议隐私政策")
        }else{
            if !checkPhone(){
                return
            }
            if !checkCode(){
                return
            }
            commonCheckVerCodeByBindAccount()
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "注册"
        initData()
        initUI()
    }
   
}
//MARK: - Private
extension ParentRegisterViewController{
    fileprivate func initUI(){
        bgView1.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
        bgView2.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
     

    }
    fileprivate func initData(){
        dataController = ParentRegisterDataController(delegate: self)
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
            "type":GetCodeType.regist.rawValue
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
    fileprivate func commonCheckVerCodeByBindAccount(){
       
        let parameter:NSMutableDictionary = [
            "phone":phoneTextField.text!,
            "verCode":codeTextField.text!
        ]
        dataController.commonCheckVerCodeByBindAccount(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                let dic:NSMutableDictionary = [
                    "phone":self.phoneTextField.text!,
                    "verCode":self.codeTextField.text!
                ]
                self.pushViewController("RegisterSettingNewPasswordViewController",sender:dic)
            }else {
            }
        }
    }

}
