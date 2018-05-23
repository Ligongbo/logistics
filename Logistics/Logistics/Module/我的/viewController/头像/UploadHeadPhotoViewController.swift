//
//  UploadHeadPhotoViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/19.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class UploadHeadPhotoViewController: BaseViewController {

    var dataController:UploadHeadPhotoDataController!
    @IBOutlet var headPhotoImageView: UIImageView!
    var alert:UIAlertController!
    var headeUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "头像"
        initData()
        initUI()

    }

}
//MARK: -Private
extension UploadHeadPhotoViewController{
    fileprivate func initUI(){
        loadRightBarButtonItem()
        initAlert()
        headPhotoImageView.sd_setImage(with: URL.init(string: FileAccessHost + headeUrl))
    }
    fileprivate func initData(){
        dataController = UploadHeadPhotoDataController(delegate: self)
        if senderParam != nil{
            headeUrl = senderParam as! String
        }
    }
    func loadRightBarButtonItem(){
        let rightBarButtonItem = UIBarButtonItem(title: "修改", style: .plain, target: self, action: #selector(self.rightBarButtonClicked(sender:)))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    @objc func rightBarButtonClicked(sender: UIBarButtonItem){
        present(alert, animated: true, completion: nil)
    }
    fileprivate func initAlert(){
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.view.tintColor = UIColor.black
        //通过拍照上传图片
        let takingPicAction:UIAlertAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.default) { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                let imagePicker:UIImagePickerController = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        //从手机相册中选择上传图片
        let okAction:UIAlertAction = UIAlertAction(title: "从手机相册选择", style: UIAlertActionStyle.default) { (UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum){
                let imagePicker:UIImagePickerController = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
                self.present(imagePicker, animated: true, completion: nil)
                
            }
        }
        let cancelAction:UIAlertAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (UIAlertAction) in
        }
        alert.addAction(takingPicAction)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
    }
    //压缩图片
    fileprivate func imageWithImageSimple(image:UIImage,newSize:CGSize)->UIImage{
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return newImage
    }
    //上传图片接口
    fileprivate func uploadPortrait(portrait:UIImage){
        let parameter:NSMutableDictionary = [
            "typeFile":"0",
            "work":MyConfig.shared().projectNameBase,
            "transaction":"1",
            "thumbnail":"0",
            "org":currentUser.orgId
        ]
        let imageData:Data = UIImageJPEGRepresentation(portrait, 0.9)! as Data
        dataController.uploadHeadPhoto(imgDataArray:  [imageData], parameter: parameter) { (isSucceed, info) in
            if isSucceed{
                self.uploadHeadUrl(portrait: portrait)
                
            }
        }
    }
    //上传头像url
    fileprivate func uploadHeadUrl(portrait:UIImage){
        let parameter:NSMutableDictionary = [
            "headUrl":dataController.model.data.count > 0 ? dataController.model.data[0].accessPath : ""
        ]
        dataController.uploadHeadUrl(parameter: parameter) { (isSucceed, info) in
            if isSucceed {
                self.headPhotoImageView.image = portrait
            }else {
                
            }
        }
        
    }
}
extension UploadHeadPhotoViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    //调用系统相册及拍照功能实现方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var chosenImage:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        chosenImage = self.imageWithImageSimple(image: chosenImage, newSize: CGSize(width: 400, height: 400))
        //调用接口
        picker.dismiss(animated: true) {
            self.uploadPortrait(portrait: chosenImage)
        }
//        picker.dismiss(animated: true, completion: {(isComplete) in
//
//            self.uploadPortrait(portrait: chosenImage)
//        })
    }
    
}
