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
    //密码
    @IBOutlet weak var passwordTextField: UITextField!
    //用户名
    @IBOutlet weak var userNameTextField: UITextField!
    
    var dataController:LoginDataController!
    
    
    //忘记密码
    @IBOutlet var forgetPasswordBtn: UIButton!
    //个人注册
    @IBOutlet var personRegisterBtn: UIButton!
    //企业注册
    @IBOutlet var companyRegisterBtn: UIButton!
    
    
   
    
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
//       pushViewController("SuggestionViewController")
        pushViewController("ForgetPwdViewController")
    }
    @IBAction func personRegisterClick(_ sender: Any) {
        pushViewController("PersonRegisterViewController")
    }
    @IBAction func companyRegisterClick(_ sender: Any) {
        pushViewController("CompanyRegisterViewController")
    }

    
    @IBAction func isShowPasswordBtn(_ sender: Any) {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        closeKeyboard()
           self.showMainTab()
//        if !checkFun(){
//            return
//        }
        
//        let parameter:NSMutableDictionary = [
//            "username":userNameTextField.text!,
//            "pwd":passwordTextField.text!,
//
//        ]
//        dataController.login(parameter: parameter) { (isSucceed, info) in
//            if isSucceed {
//                self.showMainTab()
//            }else {
//
//            }
//        }
    }
    
    func checkFun() -> Bool{
        if String.isNilOrEmpty(userNameTextField.text){
            LHAlertView.showTipAlertWithTitle("用户名不能为空")
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
        
    }
    
    fileprivate func initUI(){
       
    }
   
}
extension LoginViewController{
   
   
    
}
