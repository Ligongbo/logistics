//
//  BindAccountShowStudentOrSchoolViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/7.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class BindAccountShowStudentOrSchoolViewController: BaseViewController {
    @IBAction func finishBtnClick(_ sender: Any) {
    }
    @IBOutlet var tableView: UITableView!
    var dataController:BindAccountShowStudentOrSchoolDataController!
    var cellCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "绑定账号"
        initData()
        initUI()
    }

    

}
extension BindAccountShowStudentOrSchoolViewController{
    fileprivate func initUI(){
       initTableView()
    }
    fileprivate func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register("BindAccountShowStudentsTableViewCell")
        tableView.register("BindAccountShowSchoolTableViewCell")
        tableView.register("BindButtonTableViewCell")

    }
    
    fileprivate func initData(){
        dataController = BindAccountShowStudentOrSchoolDataController(delegate: self)
        if senderParam != nil{
            dataController.update(model: senderParam as! BindAccountModel)
        }
        if dataController.model.userType == .parent {
            cellCount = dataController.model.studentList.count + 1
        }else if dataController.model.userType == .teacher {
            cellCount = dataController.model.schoolList.count + 1
        }
        
    }
    
    fileprivate func authBindAccount(){
        var stuId = ""
        var schId = ""
        if dataController.model.userType == .teacher{
            schId = dataController.model.schoolList.count > 0 ? dataController.model.schoolList[0].schoolId : ""
            if schId == ""{
                LHAlertView.showTipAlertWithTitle("没有学校不能绑定")
                return
            }
        }else if dataController.model.userType == .parent{
            stuId = dataController.model.studentList.count > 0 ? dataController.model.studentList[0].id : ""
            if stuId == ""{
                LHAlertView.showTipAlertWithTitle("没有子女不能绑定")
                return
            }
        }
        
        let parameter:NSMutableDictionary = [
            "phone":dataController.model.phone,
            "verCode":dataController.model.verCode,
            "userType":dataController.model.userType.rawValue,
            "bindUserId":dataController.model.userId,
            "pwd":dataController.model.pwd,
            "sysType":SystemType.highSchool.rawValue,
            "stuId":stuId,
            "schId":schId,
            "orgId":dataController.model.orgId
            ]
        dataController.authBindAccount(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
               self.showConfirmLogin()
            }else {
            }
        }
    }
    func showConfirmLogin(){
        let bindAccountLoginBlock:BindAccountLoginBlock = {
            (id) in
            self.login(id:id)
        }
        let dic:NSMutableDictionary = [
            "model":dataController.model,
            "block":bindAccountLoginBlock
        ]
        let loginView = UIView.loadViewWithName("ConfirmLoginView") as! ConfirmLoginView
        loginView.update(dic: dic)
        loginView.layer.cornerRadius = 5
        loginView.clipsToBounds = true
        if dataController.model.userType == .teacher {
            loginView.frame = CGRect(x: 0, y: 0, width: Int(257 * (ScreenWidth/375)), height: 128 + dataController.model.schoolList.count * 36 + 40 + 1)
        }else if dataController.model.userType == .parent {
            loginView.frame = CGRect(x: 0, y: 0, width: Int(257 * (ScreenWidth/375)), height: 128 + dataController.model.studentList.count * 36 + 40 + 1)
        }
        
        loginView.showInWindow()
        
    }
    func login(id:String){
        var stuId = ""
        var schId = ""
        if dataController.model.userType == .teacher{
            schId = id
        }else if dataController.model.userType == .parent{
            stuId = id
        }
        let parameter:NSMutableDictionary = [
            "username":dataController.model.phone,
            "pwd":dataController.model.pwd,
            "stuId":stuId,
            "schId":schId
            
            ]
        dataController.login(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.showMainTab()
            }else {
                
            }
        }
    }
    //跳转至主页
    fileprivate func showMainTab(){
        
        
        
        
        MyConfig.shared().isLogin = true
        
        let tabbarVC = BaseTabBarViewController()
        UIApplication.shared.keyWindow?.rootViewController = tabbarVC
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
        UIApplication.shared.keyWindow?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
    }
}
extension BindAccountShowStudentOrSchoolViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return cellCount
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == cellCount - 1{
            let cell = BindButtonTableViewCell.loadCell(tableView)
            return cell
        }else{
            if dataController.model.userType == .parent {
                let cell = BindAccountShowStudentsTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.studentList[indexPath.row])
                
                return cell
            }else if dataController.model.userType == .teacher {
                let cell = BindAccountShowSchoolTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.schoolList[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == cellCount - 1{
            authBindAccount()
        }
    }
}
