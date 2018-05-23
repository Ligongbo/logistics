//
//  MineViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/17.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController {

    @IBOutlet var tableView: UITableView!
    var dataController:MineDataController!
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        initData()
        initUI()
        self.navigationItem.title = "个人中心"

        loadMyAccount()
    }
    
  }
//MARK: -Private
extension MineViewController{
    fileprivate func initUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register("MineHeadPhotoTableViewCell")
        tableView.register("MineSchoolTableViewCell")
        tableView.register("MineLogoutTableViewCell")
        
        
    }
    fileprivate func initData(){
        dataController = MineDataController(delegate: self)
    }
    //我的
    fileprivate func loadMyAccount(){
        let parameter:NSMutableDictionary = [:]
        dataController.myAccount(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.tableView.reloadData()
            }else {
                
            }
        }
        
    }
    //退出登陆接口
    fileprivate func loadLogout(){

        let parameter:NSMutableDictionary = [:]
        dataController.logout(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
                let navController = BaseNavigationViewController(rootViewController: loginVC)
                let config = MyConfig.shared()
                let userNSObjectModel = NSKeyedUnarchiver.unarchiveObject(with: config.userModel) as! UserNSObjectModel
                userNSObjectModel.token = ""
                config.userModel = NSKeyedArchiver.archivedData(withRootObject: userNSObjectModel)
                config.isLogin = false
                MyConfig.shared().isLogin = false
                UIApplication.shared.keyWindow?.rootViewController = navController
                UIApplication.shared.keyWindow?.makeKeyAndVisible()
                UIApplication.shared.keyWindow?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
            }else {
            }
        }
    }
    
}
extension MineViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentUser.userType == .teacher{
            return 7
        }else if currentUser.userType == .student{
            return 5
        }else if currentUser.userType == .parent{
            return 7
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if currentUser.userType == .teacher{
            if indexPath.row == 0{
                let cell = MineHeadPhotoTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.data)
                return cell
            }else if indexPath.row == 1{
                let cell = MineSchoolTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.data, type: "1")
                
                return cell
            }else if indexPath.row == 2{
                let cell = MineSchoolTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.data, type: "2")
                return cell
            }else if indexPath.row == 3{
                let cell = MineSchoolTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.data, type: "3")
                return cell
            }else if indexPath.row == 4{
                let cell = MineSchoolTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.data, type: "4")
                return cell
            }else if indexPath.row == 5{
                let cell = MineSchoolTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.data, type: "5")

                return cell
            }else if indexPath.row == 6{
                let cell = MineLogoutTableViewCell.loadCell(tableView)
                
                return cell
            }

        }else if currentUser.userType == .student{
            if indexPath.row == 0{
                let cell = MineHeadPhotoTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.data)
                return cell
                
            }else if indexPath.row == 1{
                let cell = MineSchoolTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.data, type: "2")
                return cell
            }else if indexPath.row == 2{
                let cell = MineSchoolTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.data, type: "4")
                return cell
            }else if indexPath.row == 3{
                let cell = MineSchoolTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.data, type: "5")
                return cell
            }else if indexPath.row == 4{
                let cell = MineLogoutTableViewCell.loadCell(tableView)
                
                return cell
            }

        }else if currentUser.userType == .parent{
            if indexPath.row == 0{
                let cell = MineHeadPhotoTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.data)
                return cell
                
            }else if indexPath.row == 1{
                let cell = MineSchoolTableViewCell.loadCell(tableView)
                
                cell.update(model: dataController.model.data, type: "6")
                return cell
            }else if indexPath.row == 2{
                let cell = MineSchoolTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.data, type: "2")
                return cell
            }else if indexPath.row == 3{
                let cell = MineSchoolTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.data, type: "3")
                return cell
            }else if indexPath.row == 4{
                let cell = MineSchoolTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.data, type: "4")
                return cell
            }else if indexPath.row == 5{
                let cell = MineSchoolTableViewCell.loadCell(tableView)
                cell.update(model: dataController.model.data, type: "5")
                return cell
            }else if indexPath.row == 6{
                let cell = MineLogoutTableViewCell.loadCell(tableView)
                
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentUser.userType == .teacher{
            if indexPath.row == 0{//头像
                
                pushViewController("UploadHeadPhotoViewController",sender:dataController.model.data.headUrl)
            }else if indexPath.row == 1{//选择学校
                //实现block
                let selectSchoolBlock:SelectSchoolBlock = {
                    (schoolName) in
                    print(schoolName)
                }
                let dic:NSMutableDictionary = [
                    "block":selectSchoolBlock
                ]
                pushViewController("MineSelectSchoolViewController",sender:dic)
            }else if indexPath.row == 2{//修改密码
                pushViewController("UpdatePasswordViewController")
                
                
            }else if indexPath.row == 3{//修改手机号
                let updatePhoneBlock:UpdatePhoneBlock = {
                    (phone) in
                    print(phone)
                }
                pushViewController("VerifyOldPhoneViewController",sender:updatePhoneBlock)
                
            }else if indexPath.row == 4{//清理缓存
                print("清理缓存")
                let tmpSize = SDImageCache.shared().getSize()
                
                SDImageCache.shared().clearDisk(onCompletion: {
                    
                    LHAlertView.showTipAlertWithTitle("为您清理\(String(format: "%.2f", Float(tmpSize)/1024/1024))M")
                })
                
                
            }else if indexPath.row == 5{//关于我们
//                let dic:Dictionary<String,String> = ["title":"关于我们","url":"https://www.baidu.com"]
//                pushViewController("CommonWebViewController", sender: dic)
                pushViewController("AboutUsViewController")
                
            }else if indexPath.row == 6 {//退出登陆
                
                LHAlertView.showAlertWithTitle("确认退出登陆吗？", msg: "", confirmButtonTitle: "确认", cancelButtonTitle: "取消", completionBlock: {
                    self.loadLogout()
                }) {
                    
                }
            }

        }else if currentUser.userType == .student{
            if indexPath.row == 0{//头像
                
                pushViewController("UploadHeadPhotoViewController",sender:dataController.model.data.headUrl)
            }else if indexPath.row == 1{//修改密码
                pushViewController("UpdatePasswordViewController")
                
                
            }else if indexPath.row == 2{//清理缓存
                print("清理缓存")
                let tmpSize = SDImageCache.shared().getSize()
                
                SDImageCache.shared().clearDisk(onCompletion: {
                    
                    LHAlertView.showTipAlertWithTitle("为您清理\(String(format: "%.2f", Float(tmpSize)/1024/1024))M")
                })
                
                
            }else if indexPath.row == 3{//关于我们
//                let dic:Dictionary<String,String> = ["title":"关于我们","url":"https://www.baidu.com"]
//                pushViewController("CommonWebViewController", sender: dic)
                pushViewController("AboutUsViewController")
                
            }else if indexPath.row == 4 {//退出登陆
                
                LHAlertView.showAlertWithTitle("确认退出登陆吗？", msg: "", confirmButtonTitle: "确认", cancelButtonTitle: "取消", completionBlock: {
                    self.loadLogout()
                }) {
                    
                }
            }

            
        }else if currentUser.userType == .parent{
            if indexPath.row == 0{//头像
                
                pushViewController("UploadHeadPhotoViewController",sender:dataController.model.data.headUrl)
            }else if indexPath.row == 1{//选择子女
                let selectStudentBlock:SelectStudentBlock = {
                    (studentName) in
                    print(studentName)
                }
                let dic:NSMutableDictionary = [
                    "block":selectStudentBlock
                ]
                pushViewController("MineSelectStudentViewController",sender:dic)
                
                
            }else if indexPath.row == 2{//修改密码
                pushViewController("UpdatePasswordViewController")
                
                
            }else if indexPath.row == 3{//修改手机号
                let updatePhoneBlock:UpdatePhoneBlock = {
                    (phone) in
                    print(phone)
                }
                pushViewController("VerifyOldPhoneViewController",sender:updatePhoneBlock)
                
            }else if indexPath.row == 4{//清理缓存
                print("清理缓存")
                let tmpSize = SDImageCache.shared().getSize()
                
                SDImageCache.shared().clearDisk(onCompletion: {
                    
                    LHAlertView.showTipAlertWithTitle("为您清理\(String(format: "%.2f", Float(tmpSize)/1024/1024))M")
                })
                
                
            }else if indexPath.row == 5{//关于我们
//                let dic:Dictionary<String,String> = ["title":"关于我们","url":"https://www.baidu.com"]
//                pushViewController("CommonWebViewController", sender: dic)
                pushViewController("AboutUsViewController")
                
            }else if indexPath.row == 6 {//退出登陆
                LHAlertView.showAlertWithTitle("确认退出登陆吗？", msg: "", confirmButtonTitle: "确认", cancelButtonTitle: "取消", completionBlock: {
                    self.loadLogout()
                }) {
                    
                }
            }

        }
    }
   
}
