//
//  MineSelectStudentViewController.swift
//  SeniorHighStudentProject
//
//  Created by 王岩 on 2017/8/19.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
typealias SelectStudentBlock = (_ StudentName:String) -> Void
typealias AddStudentBlock = (_ stuArray:Array<StudentItemModel>) -> Void
class MineSelectStudentViewController: BaseViewController {
    @IBOutlet var tableView: UITableView!
    var dataController:MineSelectStudentDataController!
    var selectStudentBlcok:SelectStudentBlock?
    var parentAccount = ""
    var pwd = ""
    var userId = ""
    
    @IBAction func addStuClick(_ sender: Any) {
        let block:AddStudentBlock = {
            (stuArray) in
            for item in stuArray{
                self.dataController.model.data.append(item)
            }
            self.tableView.reloadData()
        }
        pushViewController("MineAddStudentViewController",sender:block)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择子女"
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
            initData()
            initUI()
            loadStudentList()
        
    }
}
//MARK:-Private
extension MineSelectStudentViewController{
    
    fileprivate func initUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register("SelectSchoolTableViewCell")
        
    }
    
    fileprivate func initData(){
        dataController = MineSelectStudentDataController(delegate: self)
        
        if senderParam != nil {
            let dic = senderParam as! NSMutableDictionary
            if dic["block"] != nil{
                selectStudentBlcok = dic["block"] as? SelectStudentBlock
            }
            if dic["parentAccount"] != nil {
                parentAccount = dic["parentAccount"] as! String
            }
            if dic["pwd"] != nil {
                pwd = dic["pwd"] as! String
            }
            if dic["userId"] != nil {
                userId = dic["userId"] as! String
            }
        }
    }
    
    //获取子女列表
    func loadStudentList(){
        let parameter:NSMutableDictionary = [:]
        dataController.getStuListById(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.tableView.reloadData()
            }else {
            }
        }

//            let parameter:NSMutableDictionary = [
//                "parentAccount":parentAccount,
//                "pwd":pwd,
//                "userId":userId,
//                ]
//            dataController.getStuListByAccount(parameter: parameter) { (isSucceed, info) in
//                if isSucceed {
//                    self.tableView.reloadData()
//                }else {
//                }
//            }
        
        
    }
    //选择子女
    func loadSelectStu(index:Int){
        let parameter:NSMutableDictionary = [
            "stuId":dataController.model.data[index].id
        ]
        dataController.selectStu(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.updateUserModel(index: index)
                    self.selectStudentBlcok?(self.dataController.model.data[index].name)
                    self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    //更新userdefault数据
    fileprivate func updateUserModel(index:Int){
        let config = MyConfig.shared()
        let userNSObjectModel = NSKeyedUnarchiver.unarchiveObject(with: config.userModel) as! UserNSObjectModel
        let stuModel = dataController.model.data[index]
        userNSObjectModel.classId = stuModel.classId
        userNSObjectModel.id = stuModel.id
        userNSObjectModel.gradeId = stuModel.gradeId
        userNSObjectModel.schId = stuModel.schId
        
        
        let data = NSKeyedArchiver.archivedData(withRootObject: userNSObjectModel)
        MyConfig.shared().userModel = data
        currentUser = userNSObjectModel.toAnyObject()

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
extension MineSelectStudentViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.model.data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SelectSchoolTableViewCell.loadCell(tableView)
        if indexPath.row == dataController.model.data.count - 1{
            cell.lineLabel.isHidden = true
        }
        cell.contentLabel.text = dataController.model.data[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        loadSelectStu(index:indexPath.row)
        
    }
}
