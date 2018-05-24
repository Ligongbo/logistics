//
//  PersonMessageViewController.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/23.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class PersonMessageViewController: BaseViewController {
    
    var dataController:PersonMessageDataController!
    @IBOutlet weak var tableView: UITableView!
    var imagePicker:TZImagePickerController!
    var assetFront:PHAsset?
    var assetBack:PHAsset?
    var imageFront:UIImage?
    var imageBack:UIImage?
    
    var dataModel:PersonMessageMode = PersonMessageMode()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "个人信息完善"
        initData()
        
        initUI()
    }
}

//MARK: -Private
extension PersonMessageViewController{
    fileprivate func initData(){
        dataController = PersonMessageDataController(delegate: self)
       
        
    }
  
    fileprivate func initUI(){
      
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register("PersonMessageTipTableViewCell")
        tableView.register("PersonMessageInputTableViewCell")
        tableView.register("PersonMessagePhotoTableViewCell")
        tableView.register("PersonMessageButtonTableViewCell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    fileprivate func checkFun() -> Bool{
        if dataModel.realName == ""{
            LHAlertView.showTipAlertWithTitle("请输入姓名")
            return false
        }else  if dataModel.phone == ""{
            LHAlertView.showTipAlertWithTitle("请输入身份证号码")
            return false
        }else  if dataModel.frontUrl == ""{
            LHAlertView.showTipAlertWithTitle("请上传身份证正面照片")
            return false
        }else  if dataModel.backUrl == ""{
            LHAlertView.showTipAlertWithTitle("请上传身份证反面照片")
            return false
        }
        return true
    }
}
extension PersonMessageViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if indexPath.row == 0{
            let cell = PersonMessageTipTableViewCell.loadCell(tableView)
          
            return cell
        }else if indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 6 || indexPath.row == 7{
            let cell = PersonMessageInputTableViewCell.loadCell(tableView)
            if indexPath.row == 1{
                cell.update(key: "姓        名：", value: dataModel.realName, placeholder: "请输入您的真实姓名", limit: 20,model: dataModel)
            }else if indexPath.row == 2{
                cell.update(key: "电        话：", value: dataModel.phone, placeholder: "请输入常用电话", limit: 11,model: dataModel)
            }else if indexPath.row == 3{
                cell.update(key: "身份证号：", value: dataModel.idCard, placeholder: "请输入身份证号", limit: 18,model: dataModel)
            }else if indexPath.row == 6{
                cell.update(key: "常用住址：", value: dataModel.address, placeholder: "请输入常用地址", limit: 100,model: dataModel)
            }else if indexPath.row == 7{
                cell.update(key: "详细地址：", value: dataModel.addressDetail, placeholder: "请输入详细地址", limit: 200,model: dataModel)
            }
            
            
            return cell
        }else if indexPath.row == 4 || indexPath.row == 5{
            
            let cell = PersonMessagePhotoTableViewCell.loadCell(tableView)
            
            return cell
        }else if indexPath.row ==  8{
            
            let cell = PersonMessageButtonTableViewCell.loadCell(tableView)
           cell.delegate = self
            return cell
        }
        return UITableViewCell()
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 || indexPath.row == 5 {
           
            
            let cell = tableView.cellForRow(at: indexPath) as! PersonMessagePhotoTableViewCell
            initImagePick()
            imagePicker.maxImagesCount = 1
            imagePicker.urlCount = 0
            if indexPath.row == 4{
                if assetFront != nil{
                    imagePicker?.selectedAssets = [assetFront]
                }
                imagePicker?.didFinishPickingPhotosHandle = {
                    (photos,assets,isSelectOriginalPhoto) in
                    if photos != nil && (photos?.count)! > 0{
                        cell.selectImage.image = photos![0]
                        self.imageFront = photos![0]
                    }
                    
                }
            }else{
                if assetBack != nil{
                    imagePicker?.selectedAssets = [assetBack]
                }
                imagePicker?.didFinishPickingPhotosHandle = {
                    (photos,assets,isSelectOriginalPhoto) in
                    if photos != nil && (photos?.count)! > 0{
                        cell.selectImage.image = photos![0]
                        self.imageBack = photos![0]
                    }
                    
                }
            }
            
            
            
           
            UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker!, animated: true, completion: nil)
            
            
        }else if indexPath.row == 5 {
            
            let cell = PersonMessagePhotoTableViewCell.loadCell(tableView)
            
            
        }
    }
}
extension PersonMessageViewController:TZImagePickerControllerDelegate,PersonMessageFinishProtocol{
    func initImagePick(){
        imagePicker = TZImagePickerController.init(maxImagesCount: 1, delegate: self,urlCount:0)
        // 在内部是否显示拍照按钮
        imagePicker?.allowTakePicture = true
        imagePicker?.sortAscendingByModificationDate = false
        
        
    }
    func personMessageFinishProtocol() {
        print(dataModel.realName)
        if checkFun(){
            
        }
        
    }
    
    
}
