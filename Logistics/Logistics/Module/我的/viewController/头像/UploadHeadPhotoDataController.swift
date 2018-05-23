//
//  UploadHeadPhotoDataController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/28.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class UploadHeadPhotoDataController: BaseDataController {
    var model = UploadFileDataModel()
    //上传头像图片
    func uploadHeadPhoto(imgDataArray:Array<Data>,parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.uploadFile(delegate: self.delegate!, imgDataArray: imgDataArray,parameter:parameter) { (isSuccess, result) in
            if isSuccess{
                self.model = Mapper<UploadFileDataModel>().map(JSONObject: result)!

                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
    //上传头像路径
    func uploadHeadUrl(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.uploadHeadUrl(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
}
