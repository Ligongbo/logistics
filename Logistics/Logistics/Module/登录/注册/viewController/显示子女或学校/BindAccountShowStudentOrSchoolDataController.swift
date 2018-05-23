//
//  BindAccountShowStudentOrSchoolDataController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/7.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class BindAccountShowStudentOrSchoolDataController: BaseDataController {

    var model:BindAccountModel!//展示子女或学校的model 上个页面传过来的model
    var resultModel:ShowStudentOrSchoolSubmitModel = ShowStudentOrSchoolSubmitModel()//提交成功后的model
    func update(model:BindAccountModel){
        self.model = model
    }
    //账号绑定
    func authBindAccount(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.authBindAccount(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.resultModel = Mapper<ShowStudentOrSchoolSubmitModel>().map(JSONObject: result)!
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
    
    func login(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.login(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                let model = Mapper<LoginModel>().map(JSONObject: result)
                if model != nil{
                    if model!.data.userType == .parent{
                        model!.data.schId = model!.data.selectStuSchId
                        model!.data.id = model!.data.selectStuId
                    }else if model!.data.userType == .teacher{
                        model!.data.schId = model!.data.selectSchId
                    }
                    let data = NSKeyedArchiver.archivedData(withRootObject: model?.data.toNSObject())
                    MyConfig.shared().userModel = data
                    currentUser = model?.data
                    //                MyConfig.shared().isLogin = true
                    completionBlock(true, nil)
                }else{
                    completionBlock(false, nil)
                }
            }else{
                completionBlock(false, nil)
            }
        }
    }
}
