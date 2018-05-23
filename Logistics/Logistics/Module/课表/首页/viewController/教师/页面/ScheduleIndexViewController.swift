//
//  ScheduleIndexViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/8.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class ScheduleIndexViewController: BaseViewController {

    @IBOutlet weak var noDataLabel: UILabel!
    var dataController:ScheduleIndexDataController!
    @IBOutlet weak var tableView: UITableView!
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        initData()
        initUI()
        let notificationName = Notification.Name(rawValue: "test\(index)")
        NotificationCenter.default.addObserver(self, selector: #selector(request(notification:)), name: notificationName, object: nil)
    }
}
//MARK: - Private
extension ScheduleIndexViewController{
    fileprivate func initData(){
        dataController = ScheduleIndexDataController(delegate: self)
    }
    fileprivate func initUI(){
        initTableView()
    }
    @objc func request(notification:Notification){
        NotificationCenter.default.removeObserver(self)
//        let userInfo = notification.userInfo as! [String:Int]
        if currentUser.userType == .teacher {
            courseTeacher()
        }else{
            courseStudent()
        }
        
    }
    fileprivate func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register("ScheduleIndexTableViewCell")
        
    }
    //教师课表（教师任课表）
    fileprivate func courseTeacher(){
        
        let parameter:NSMutableDictionary = [
            "schId":currentUser.schId,
            "week":index + 1,
            "userId":currentUser.userId
        ]
        dataController.courseTeacher(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.tableView.reloadData()
                if self.dataController.model.data.count > 0 {
                    self.noDataLabel.isHidden = true
                }else{
                    self.noDataLabel.isHidden = false
                }
                
            }else {
                
            }
        }
    }
    //学生课表（班级课表）
    fileprivate func courseStudent(){
        
        let parameter:NSMutableDictionary = [
            "schId":currentUser.schId,
            "week":index + 1,
            "classId":currentUser.classId
        ]
        dataController.courseStudent(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.tableView.reloadData()
                if self.dataController.model.data.count > 0 {
                    self.noDataLabel.isHidden = true
                }else{
                    self.noDataLabel.isHidden = false
                }
                
            }else {
                
            }
        }
    }
}
extension ScheduleIndexViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataController.model.data.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ScheduleIndexTableViewCell.loadCell(tableView)
        if currentUser.userType == .teacher {
            cell.updateTeacher(model: dataController.model.data[indexPath.row])
        }else{
            cell.updateStudent(model: dataController.model.data[indexPath.row])
        }
        
        return cell
    }
    
}

