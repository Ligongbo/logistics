//
//  MineSelectSchoolViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/19.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

typealias SelectSchoolBlock = (_ schoolName:String) -> Void
class MineSelectSchoolViewController: BaseViewController {
    @IBOutlet var tableView: UITableView!
    var dataController:MineSelectSchoolDataController!
    var selectSchoolBlcok:SelectSchoolBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择学校"

        initData()
        initUI()
        loadSchoolList()
    }
}
//MARK:-Private
extension MineSelectSchoolViewController{
    
    fileprivate func initUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register("SelectSchoolTableViewCell")

    }
    
    fileprivate func initData(){
        dataController = MineSelectSchoolDataController(delegate: self)
        if senderParam != nil {
            let dic = senderParam as! NSMutableDictionary
            if dic["block"] != nil{
                selectSchoolBlcok = dic["block"] as! SelectSchoolBlock
            }
        }
    }
    //获取学校列表
    func loadSchoolList(){
        let parameter:NSMutableDictionary = [:]
        dataController.getSchoolList(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.tableView.reloadData()
            }else {
            }
        }
    }
    //选择学校
    func loadSelectSchool(index:Int){
        let parameter:NSMutableDictionary = [
            "schId":dataController.model.data[index].schoolId
        ]
        dataController.selectSchool(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.updateUserModel(index: index)
   
                self.selectSchoolBlcok?(self.dataController.model.data[index].schoolName)
                self.navigationController?.popViewController(animated: true)

            }else {
                self.showMainTab()
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
    //更新userdefault数据
    fileprivate func updateUserModel(index:Int){
        let config = MyConfig.shared()
        let userNSObjectModel = NSKeyedUnarchiver.unarchiveObject(with: config.userModel) as! UserNSObjectModel
        let schModel = dataController.model.data[index]
  
        userNSObjectModel.schId = schModel.schoolId
        let data = NSKeyedArchiver.archivedData(withRootObject: userNSObjectModel)
        MyConfig.shared().userModel = data
        currentUser = userNSObjectModel.toAnyObject()
        
    }

}
extension MineSelectSchoolViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.model.data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SelectSchoolTableViewCell.loadCell(tableView)
        if indexPath.row == 1{
            cell.lineLabel.isHidden = true
        }
        cell.contentLabel.text = dataController.model.data[indexPath.row].schoolName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            loadSelectSchool(index:indexPath.row)
    }
}
