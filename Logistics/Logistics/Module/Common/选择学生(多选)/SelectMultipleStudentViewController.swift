//
//  SelectMultipleStudentViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/22.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
typealias SelectStudentsBlock = (_ students:Array<SelectMultipleStudentModel>) -> Void
class SelectMultipleStudentViewController: BaseViewController {

    
    @IBOutlet var tableView: UITableView!
    var dataController:SelectMultipleStudentDataController!
    @IBAction func finishButtonClick(_ sender: Any) {
        dataController.selectStudentsBlock?(dataController.selectArray)
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择学生"
        initData()
        initUI()
        loadRequest()
    

    }
}
//MARK: -Private
extension SelectMultipleStudentViewController{
    fileprivate func initUI(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register("SelectMultipleStudentTableViewCell")
    }
    fileprivate func initData(){
        dataController = SelectMultipleStudentDataController(delegate: self)
        if senderParam != nil{
            
            dataController.update(dic: senderParam as! NSMutableDictionary)
        }

    }
    fileprivate func loadRequest(){
        let parameter:NSMutableDictionary = [
            
            "classId":dataController.calssId
        ]
        dataController.getStudents(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                
                self.tableView.reloadData()
                
            }else {
                
            }
        }
    }
    
}
extension SelectMultipleStudentViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataController.sectionTitles[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataController.sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.groupedStudents[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return defaultTableViewSectionTitlesArray
//        return dataController.sectionTitles
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        LHAlertView.showTipAlertWithTitle("\(title)", postion: .center)
        return dataController.sectionTitles.index(of: title) == nil ? -1 : dataController.sectionTitles.index(of: title)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SelectMultipleStudentTableViewCell.loadCell(tableView)
        cell.update(student: dataController.groupedStudents[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataController.groupedStudents[indexPath.section][indexPath.row]
        model.isSelected = !model.isSelected
        tableView.reloadRows(at: [indexPath], with: .none)
        
    }
}
