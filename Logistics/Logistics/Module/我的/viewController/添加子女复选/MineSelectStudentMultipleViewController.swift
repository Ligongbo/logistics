//
//  MineSelectStudentMultipleViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/4.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class MineSelectStudentMultipleViewController: BaseViewController {
    
    var block:AddStudentBlock?
    @IBOutlet var tableView: UITableView!
    var dataController:MineSelectStudentMultipleDataController!
    @IBAction func finishButtonClick(_ sender: Any) {
        authAddBindAccount()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "选择子女"
        initData()
        initUI()
    }
}
//MARK: - Private
extension MineSelectStudentMultipleViewController{
    fileprivate func initUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register("BindAccountShowStudentsTableViewCell")

    }
    fileprivate func initData(){
        dataController = MineSelectStudentMultipleDataController(delegate: self)
        if senderParam != nil {
            dataController.update(dic:senderParam as! NSMutableDictionary)
        }
    }
    //添加账号绑定
    func authAddBindAccount(){
        let parameter:NSMutableDictionary = [
            "bindUserId":dataController.bindUserId
        ]
        dataController.authAddBindAccount(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                
                for vc in (self.navigationController?.childViewControllers)!{
                    if vc is MineSelectStudentViewController{
                        self.navigationController?.popToViewController(vc, animated: true)
                    }
                }
            }
        }
    }
}
extension MineSelectStudentMultipleViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.stuArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BindAccountShowStudentsTableViewCell.loadCell(tableView)
        cell.update(model: dataController.stuArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
    }
}
