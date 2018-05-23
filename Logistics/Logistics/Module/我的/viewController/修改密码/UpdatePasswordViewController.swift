//
//  UpdatePasswordViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/19.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class UpdatePasswordViewController: BaseViewController,UITextFieldDelegate {

    var dataController:UpdatePasswordDataController!
    @IBAction func isShowClick(_ sender: UIButton) {
        let img = UIImage.init(named: "main_MutiCheck_Off")
        if sender.currentBackgroundImage == img{
            
            sender.setBackgroundImage(UIImage.init(named: "main_MutiCheck_On"), for: .normal)
            oldPasswordTextField.isSecureTextEntry = false
            newPasswordTextField.isSecureTextEntry = false
            confirmPasswordTextField.isSecureTextEntry = false
        }else {
            
            sender.setBackgroundImage(UIImage.init(named: "main_MutiCheck_Off"), for: .normal)
            oldPasswordTextField.isSecureTextEntry = true
            newPasswordTextField.isSecureTextEntry = true
            confirmPasswordTextField.isSecureTextEntry = true
        }
        
    }
    @IBAction func finishBtnClick(_ sender: Any) {
        if checkFun(){
            loadUpdatePwd()
        }
        
        
    }

    
    @IBOutlet var confirmPasswordTextField: BaseTextField!
    @IBOutlet var newPasswordTextField: BaseTextField!
    @IBOutlet var oldPasswordTextField: BaseTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "修改密码"
        initData()
        initUI()
    }
}
//MARK: -Private
extension UpdatePasswordViewController{
    fileprivate func initUI(){
        oldPasswordTextField.delegate = self;
        oldPasswordTextField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        oldPasswordTextField.leftViewMode = .always
        
        newPasswordTextField.delegate = self;
        newPasswordTextField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        newPasswordTextField.leftViewMode = .always
        
        confirmPasswordTextField.delegate = self;
        confirmPasswordTextField.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        confirmPasswordTextField.leftViewMode = .always

    }
    fileprivate func initData(){
        dataController = UpdatePasswordDataController(delegate: self)
    }
    fileprivate func loadUpdatePwd(){
        let parameter:NSMutableDictionary = [
            "pwd":oldPasswordTextField.text,
            "newPwd":newPasswordTextField.text
        ]
        dataController.updatePwd(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.navigationController?.popViewController(animated: true)
            }else {
                
            }
        }

    }
    fileprivate func checkFun()->Bool{
        if String.isNilOrEmpty(oldPasswordTextField.text){
            LHAlertView.showTipAlertWithTitle("原密码不能为空")
            return false
        }
        if String.isNilOrEmpty(newPasswordTextField.text){
            LHAlertView.showTipAlertWithTitle("新密码不能为空")
            return false
        }
        if newPasswordTextField.text != confirmPasswordTextField.text{
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
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        return string.isNumOrString()
//    }

}
