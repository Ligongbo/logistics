//
//  LoginViewController.swift
//  BatterProject
//
//  Created by 王岩 on 2017/7/10.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var passwordTextField: BaseTextField!
    @IBOutlet weak var userNameTextField: BaseTextField!
    var dataController:LoginDataController!
    
    @IBOutlet var bindAccountBtn: UIButton!
    @IBOutlet var forgetPasswordBtn: UIButton!
    @IBOutlet var changeAreaButton: UIButton!
    
    
    //切换区域按钮点击
    @IBAction func changeAreaButtonClicked(_ sender: UIButton) {
        pushViewController("ChangeAreaViewController", sender: nil) { (info) in
            if info != nil && info is BaseAreaListModel{
                let area = info as! BaseAreaListModel
                UserDefaults.standard.setValue(area.id, forKey: AreaIdSandBoxKey)
                UserDefaults.standard.setValue(area.name, forKey: AreaNameSandBoxKey)
                HostAddress = area.serviceUrl
                UserDefaults.standard.set(area.serviceUrl, forKey: HostAddressSandBoxKey)
                UserDefaults.standard.synchronize()
                MSDataProvider.initBaseClient()
                self.changeAreaButton.setTitle(area.name + "[切换区域]", for: .normal)
                self.loginBtn.isEnabled = true
                self.bindAccountBtn.isEnabled = true
                self.forgetPasswordBtn.isEnabled = true
    
                
            }
            else{
                UserDefaults.standard.setValue(nil, forKey: AreaIdSandBoxKey)
                UserDefaults.standard.setValue(nil, forKey: AreaNameSandBoxKey)
//                UserDefaults.standard.set("", forKey: HostAddressSandBoxKey)
                UserDefaults.standard.synchronize()
                self.loginBtn.isEnabled = false
                self.bindAccountBtn.isEnabled = false
                self.forgetPasswordBtn.isEnabled = false
                self.changeAreaButton.setTitle("[切换区域]", for: .normal)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    @IBAction func forgetPwdButtonClicked(_ sender: UIButton) {
        pushViewController("ForgetPwdViewController")
    }
    @IBAction func parentRegisterClick(_ sender: Any) {
        pushViewController("ParentRegisterViewController")
    }

    
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        closeKeyboard()
        if !checkFun(){
            return
        }
        
        let parameter:NSMutableDictionary = [
            "username":userNameTextField.text!,
            "pwd":passwordTextField.text!,
            
        ]
        dataController.login(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.showMainTab()
            }else {

            }
        }
    }
    
    func checkFun() -> Bool{
        if String.isNilOrEmpty(userNameTextField.text){
            LHAlertView.showTipAlertWithTitle("手机号/账号不能为空")
            return false
        }
        if String.isNilOrEmpty(passwordTextField.text){
            LHAlertView.showTipAlertWithTitle("密码不能为空")
            return false
        }
        return true
    }
}

extension LoginViewController{
    //跳转至主页
    fileprivate func showMainTab(){
        
        
        
     
//        MyConfig.shared().isLogin = true
        
        let tabbarVC = BaseTabBarViewController()
        UIApplication.shared.keyWindow?.rootViewController = tabbarVC
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
        UIApplication.shared.keyWindow?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
    }
    
    fileprivate func initData(){
        dataController = LoginDataController(delegate: self)
        if !checkAreaIsLegal(){
            loginBtn.isEnabled = false
            bindAccountBtn.isEnabled = false
            forgetPasswordBtn.isEnabled = false
            
        }
    }
    
    fileprivate func initUI(){
        loginBtn.layer.cornerRadius = 5
        bgView.layer.cornerRadius = 5
        bgView.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
        bgView.layer.borderWidth = 1
        initChangeAreaButton()
    }
    fileprivate func initChangeAreaButton(){
        changeAreaButton.setTitle(areaName + "[切换区域]", for: .normal)
    }
    fileprivate func checkAreaIsLegal() -> Bool{
        if String.isNilOrEmpty(areaId){
            return false
        }
        return true
    }
}
extension LoginViewController{
   
   
    
}
