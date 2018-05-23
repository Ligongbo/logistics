//
//  UpdatePhoneViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/19.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

typealias UpdatePhoneBlock = (_ phone:String) -> Void
class UpdatePhoneViewController: BaseViewController {

    @IBOutlet var codeTextField: BaseTextField!
    @IBOutlet var phoneTextField: BaseTextField!
    var updatePhoneBlock:UpdatePhoneBlock?
    var dataController:UpdatePhoneDataController!
    var oldPhoneVerCode = ""
    var oldPhone = ""

    
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
    
    @IBAction func nextBtnClick(_ sender: Any) {
        closeKeyboard()
        if !checkPhone(){
            return
        }
        if !checkCode(){
            return
        }
        loadBindPhone()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "修改手机号"
        initData()
        initUI()

    }
}
//MARK:-Private
extension UpdatePhoneViewController{
    
    fileprivate func initUI(){
        bgView1.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
        bgView2.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor

    }
    
    fileprivate func initData(){
        dataController = UpdatePhoneDataController(delegate: self)
        if senderParam != nil {
            let dic = senderParam as! NSMutableDictionary
            if dic["block"] != nil{
                updatePhoneBlock = dic["block"] as! UpdatePhoneBlock
            }
            if dic["oldPhone"] != nil{
                oldPhone = dic["oldPhone"] as! String
            }
            if dic["oldPhoneVerCode"] != nil{
                oldPhoneVerCode = dic["oldPhoneVerCode"] as! String
            }

            
        }
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
            "type":GetCodeType.updatePhoneAndBindPhone.rawValue
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
    

    fileprivate func loadBindPhone(){
        let parameter:NSMutableDictionary = [
            "phone":phoneTextField.text!,
            "verCode":codeTextField.text!,
            "oldPhoneVerCode":oldPhoneVerCode,
            "oldPhone":oldPhone
        ]
        dataController.firstBindPhone(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.updatePhoneBlock?(self.phoneTextField.text!)
                let viewControllers = self.navigationController?.childViewControllers
                for vc in viewControllers!{
                    if vc is MineViewController{
                        self.navigationController?.popToViewController(vc, animated: true)
                    }
                }
            }else {
            }
        }
        
    }
}
