//
//  BindPhoneFirstViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class BindPhoneFirstViewController: BaseViewController {
    
    var dataController:BindPhoneFirstDataController!
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
    var isAgree = false //是否同意
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var bgView1: UIView!
    @IBOutlet var bgView2: UIView!
    
    @IBOutlet var codeTextField: BaseTextField!
    @IBOutlet var phoneTextField: BaseTextField!
    @IBOutlet var getCodeButton: UIButton!
    @IBAction func getCodeClick(_ sender: UIButton) {
        loadGetVercode()
    }
    @IBAction func protocolClick(_ sender: Any) {
        print("用户协议")
    }
    @IBAction func finishBtnClick(_ sender: Any) {
        loadBindPhone()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "绑定手机号"
        initData()
        initUI()
    }
    
}
extension BindPhoneFirstViewController{
    fileprivate func initUI(){
        bgView1.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
        bgView2.layer.borderColor = UIColor(hexString: "EFEFF4").cgColor
    }
    fileprivate func initData(){
        dataController = BindPhoneFirstDataController(delegate: self)
    }
    //跳转至主页
    fileprivate func showMainTab(){
        MyConfig.shared().isLogin = true
        let tabbarVC = BaseTabBarViewController()
        UIApplication.shared.keyWindow?.rootViewController = tabbarVC
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
        UIApplication.shared.keyWindow?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
    }
    fileprivate func loadBindPhone(){
//        let parameter:NSMutableDictionary = [
//            "phone":phoneTextField.text!,
//            "verCode":codeTextField.text!
//        ]
//        dataController.firstBindPhone(parameter: parameter) { (isSucceed, info) in
//            if isSucceed {
//                if currentUser.userType == .teacher{
//                    self.pushViewController("MineSelectSchoolViewController")
//                }else if currentUser.userType == .parent{
//                    self.pushViewController("MineSelectStudentViewController")
//                }
//                
//            }else {
//            }
//        }
        let dic:NSMutableDictionary = [
            "type":"1"
        ]
        self.pushViewController("MineSelectStudentViewController",sender:dic)

    }
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

    
}
