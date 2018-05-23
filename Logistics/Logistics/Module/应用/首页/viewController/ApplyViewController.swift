//
//  ApplyViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/17.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class ApplyViewController: BaseViewController {

 
    @IBOutlet var tableView: UITableView!
    

    var dataController:ApplyDataController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initData()
        initUI()
        loadRequest()
        self.view.backgroundColor = UIColor.white
        //TODO
//        MyConfig.shared().isLogin = false
        
        
    }


  }

extension ApplyViewController{

    fileprivate func initUI(){
        self.automaticallyAdjustsScrollViewInsets = false
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.estimatedRowHeight = 44
//        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register("ApplyCollectionTableViewCell")
        tableView.register("ApplyBannerTableViewCell")

    }
    fileprivate func initData(){
        dataController = ApplyDataController(delegate: self)
    }
    
    fileprivate func loadRequest(){
        let parameter:NSMutableDictionary = ["id":"9000"]
        
        dataController.getApply(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.getCarouselList()
//                self.tableView.reloadData()
            }else {
                //TODO
                
            }
        }
    }
    fileprivate func getCarouselList(){
        let parameter:NSMutableDictionary = [:]
        
        dataController.getCarouselList(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.tableView.reloadData()
            }else {
                
            }
        }
    }
}
extension ApplyViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataController.cellCount
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = ApplyBannerTableViewCell.loadCell(tableView)
//            let arr = ["https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4267222417,1017407570&fm=200&gp=0.jpg","https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3144465310,4114570573&fm=117&gp=0.jpg"]
//            cell.initCell(dataArray: arr)
            cell.initCell(model: dataController.bannerModel)
            return cell
        }else{
            let cell = ApplyCollectionTableViewCell.loadCell(tableView)
            cell.initCell(delegate: self, dataArray: dataController.model.data)
            cell.backgroundColor = UIColor.clear
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return ScreenWidth * 480 / 1080
        }else {
            let height = ((ScreenWidth ) / 3) * CGFloat(ceil(Double((dataController.model.data.count)) / 3)) + CGFloat(ceil(Double((dataController.model.data.count) ) / 3))
           return height
        }
        
    }
}
