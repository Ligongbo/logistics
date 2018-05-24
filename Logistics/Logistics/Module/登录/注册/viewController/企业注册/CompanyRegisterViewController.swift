//
//  CompanyRegisterViewController.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/23.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class CompanyRegisterViewController: BaseViewController {

    var dataController:PersonMessageDataController!
    @IBOutlet weak var tableView: UITableView!
    var imagePicker:TZImagePickerController!
    var saveView:CompanyRegisterSuccessView?
    
    var dataModel:CompanyRegisterModel = CompanyRegisterModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "企业注册"
        initData()
        
        initUI()
    }
   

}

//MARK: -Private
extension CompanyRegisterViewController{
    fileprivate func initData(){
        dataController = PersonMessageDataController(delegate: self)
       
    }
    
    fileprivate func initUI(){
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register("CompanyRegisterInputTableViewCell")
        tableView.register("CompanyRegisterPhotoTableViewCell")
        tableView.register("PersonMessageButtonTableViewCell")
        tableView.register("CompanyRegisterTipTableViewCell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    fileprivate func checkFun() -> Bool{
        if dataModel.companyName == ""{
            LHAlertView.showTipAlertWithTitle("未输入企业名称，请输入企业名称。")
            return false
        }else  if dataModel.registerAddress == ""{
            LHAlertView.showTipAlertWithTitle("未输入注册地址，请输入注册地址。")
            return false
        }else  if dataModel.responsiblePersonName == ""{
            LHAlertView.showTipAlertWithTitle("未输入负责人，请输入负责人")
            return false
        }else  if dataModel.responsiblePersonPhone == ""{
            LHAlertView.showTipAlertWithTitle("未输入负责人电话，请输入负责人电话")
            return false
        }else  if !dataModel.responsiblePersonPhone.isLegalMobile(){
           
            return false
        }else  if dataModel.responsiblePersonPhone == ""{
            LHAlertView.showTipAlertWithTitle("未上传门店照片，请上传")
            return false
        }else  if dataModel.responsiblePersonPhone == ""{
            LHAlertView.showTipAlertWithTitle("未上传营业执照，请上传营业执照")
            return false
        }else  if dataModel.responsiblePersonPhone == ""{
            LHAlertView.showTipAlertWithTitle("未上传企业LOGO或头像，请上传企业LOGO或头像")
            return false
        }
        return true
    }
}
extension CompanyRegisterViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row <= 5{
              let cell = CompanyRegisterInputTableViewCell.loadCell(tableView)
            if indexPath.row > 3{
                cell.titleImageView.isHidden = true
            }else{
                cell.titleImageView.isHidden = false
            }
            if indexPath.row == 0{
                cell.update(key: "企业名称：", value: dataModel.companyName, placeholder: "请输入公司名称", limit: 50,model: dataModel)
            }else if indexPath.row == 1{
                cell.valueTextField.isEnabled = false
                cell.update(key: "注册地址：", value: dataModel.registerAddress, placeholder: "请输入营业执照注册地址", limit: 100,model: dataModel)
            }else if indexPath.row == 2{
                cell.update(key: "负  责  人：", value: dataModel.responsiblePersonName, placeholder: "请输入负责人", limit: 20,model: dataModel)
            }else if indexPath.row == 3{
                cell.update(key: "负责人电话：", value: dataModel.responsiblePersonPhone, placeholder: "请输入负责人电话", limit: 11,model: dataModel)
            }else if indexPath.row == 4{
                cell.update(key: "纳  税  号：", value: dataModel.payNumber, placeholder: "请输入纳税人识别号", limit: 20,model: dataModel)
            }else if indexPath.row == 5{
                cell.update(key: "企业电话：", value: dataModel.companyPhone, placeholder: "请输业电话号码", limit: 11,model: dataModel)
            }
            
            return cell
        }else if indexPath.row >= 6 && indexPath.row <= 11{
            let cell = CompanyRegisterPhotoTableViewCell.loadCell(tableView)
            if indexPath.row > 8{
               cell.mustImageView.isHidden = true
            }else{
               cell.mustImageView.isHidden = false
            }
            if indexPath.row == 6{
                if dataModel.imageShop != nil{
                    cell.selectImage.image = dataModel.imageShop
                }else{
                    cell.selectImage.image = UIImage()
                }
            }else if indexPath.row == 7{
                if dataModel.imageBusinessLicence != nil{
                    cell.selectImage.image = dataModel.imageBusinessLicence
                }else{
                    cell.selectImage.image = UIImage()
                }
            }else if indexPath.row == 8{
                if dataModel.imageLogo != nil{
                    cell.selectImage.image = dataModel.imageLogo
                }else{
                    cell.selectImage.image = UIImage()
                }
            }else if indexPath.row == 9{
                if dataModel.imageCachet != nil{
                    cell.selectImage.image = dataModel.imageCachet
                }else{
                    cell.selectImage.image = UIImage()
                }
            }else if indexPath.row == 10{
                if dataModel.imageTax != nil{
                    cell.selectImage.image = dataModel.imageTax
                }else{
                    cell.selectImage.image = UIImage()
                }
            }else if indexPath.row == 11{
                if dataModel.imageOrganization != nil{
                    cell.selectImage.image = dataModel.imageOrganization
                }else{
                    cell.selectImage.image = UIImage()
                }
            }
            
            
            return cell
        }else if indexPath.row == 12{
            
            let cell = PersonMessageButtonTableViewCell.loadCell(tableView)
            cell.delegate = self
            cell.confirmBtn.setTitle("下一步", for: .normal)
            return cell
        }else if indexPath.row ==  13{
            
            let cell = CompanyRegisterTipTableViewCell.loadCell(tableView)
            
            return cell
        }
        return UITableViewCell()
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= 6 && indexPath.row <= 11{
              let cell = tableView.cellForRow(at: indexPath) as! CompanyRegisterPhotoTableViewCell
            
        
            initImagePick()
            imagePicker.maxImagesCount = 1
            imagePicker.urlCount = 0
            if indexPath.row == 6{
                if dataModel.assetShop != nil{
                    imagePicker?.selectedAssets = [dataModel.assetShop!]
                }
                imagePicker?.didFinishPickingPhotosHandle = {
                    (photos,assets,isSelectOriginalPhoto) in
                    if photos != nil && (photos?.count)! > 0{
                        cell.selectImage.image = photos![0]
                        self.dataModel.imageShop = photos![0]
                    }
                    
                }
            }else if indexPath.row == 7{
                if dataModel.assetBusinessLicence != nil{
                    imagePicker?.selectedAssets = [dataModel.assetBusinessLicence!]
                }
                imagePicker?.didFinishPickingPhotosHandle = {
                    (photos,assets,isSelectOriginalPhoto) in
                    if photos != nil && (photos?.count)! > 0{
                        cell.selectImage.image = photos![0]
                        self.dataModel.imageBusinessLicence = photos![0]
                    }
                    
                }
            }else if indexPath.row == 8{
                if dataModel.assetLogo != nil{
                    imagePicker?.selectedAssets = [dataModel.assetLogo!]
                }
                imagePicker?.didFinishPickingPhotosHandle = {
                    (photos,assets,isSelectOriginalPhoto) in
                    if photos != nil && (photos?.count)! > 0{
                        cell.selectImage.image = photos![0]
                        self.dataModel.imageLogo = photos![0]
                    }
                    
                }
            }else if indexPath.row == 9{
                if dataModel.assetCachet != nil{
                    imagePicker?.selectedAssets = [dataModel.assetCachet!]
                }
                imagePicker?.didFinishPickingPhotosHandle = {
                    (photos,assets,isSelectOriginalPhoto) in
                    if photos != nil && (photos?.count)! > 0{
                        cell.selectImage.image = photos![0]
                        self.dataModel.imageCachet = photos![0]
                    }
                    
                }
            }else if indexPath.row == 10{
                if dataModel.assetTax != nil{
                    imagePicker?.selectedAssets = [dataModel.assetTax!]
                }
                imagePicker?.didFinishPickingPhotosHandle = {
                    (photos,assets,isSelectOriginalPhoto) in
                    if photos != nil && (photos?.count)! > 0{
                        cell.selectImage.image = photos![0]
                        self.dataModel.imageTax = photos![0]
                    }
                    
                }
            }else if indexPath.row == 11{
                if dataModel.assetOrganization != nil{
                    imagePicker?.selectedAssets = [dataModel.assetOrganization!]
                }
                imagePicker?.didFinishPickingPhotosHandle = {
                    (photos,assets,isSelectOriginalPhoto) in
                    if photos != nil && (photos?.count)! > 0{
                        cell.selectImage.image = photos![0]
                        self.dataModel.imageOrganization = photos![0]
                    }
                    
                }
            }
            
            
            
            
            
            UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker!, animated: true, completion: nil)
            
            
        }
    }
}
extension CompanyRegisterViewController:TZImagePickerControllerDelegate,PersonMessageFinishProtocol{
    func initImagePick(){
        imagePicker = TZImagePickerController.init(maxImagesCount: 1, delegate: self,urlCount:0)
        // 在内部是否显示拍照按钮
        imagePicker?.allowTakePicture = true
        imagePicker?.sortAscendingByModificationDate = false
        
        
    }
    func personMessageFinishProtocol() {
        print(dataModel.companyName)
        //        if checkFun(){
        showSuccess()
//    }
        
        
    }
    func showSuccess(){
        saveView = UIView.loadViewWithName("CompanyRegisterSuccessView") as? CompanyRegisterSuccessView
        saveView?.backgroundColor = UIColor.clear
        saveView?.frame = CGRect(x: 0, y: 0, width: 240, height: 240)
        saveView?.clipsToBounds = true
        saveView?.layer.cornerRadius = 5
        saveView?.delegate = self
        saveView?.showInWindow()
        
      
    }
    
    
}
extension CompanyRegisterViewController:CompanyRegisterSuccessProtocol{
    func companyRegisterSuccessFinishProtocol() {
        pushViewController("PersonRegisterViewController",sender:"company")//企业
    }
    func companyRegisterSuccesslookProtocol() {
        let tabbarVC = BaseTabBarViewController()
        UIApplication.shared.keyWindow?.rootViewController = tabbarVC
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
        UIApplication.shared.keyWindow?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
    }
}
