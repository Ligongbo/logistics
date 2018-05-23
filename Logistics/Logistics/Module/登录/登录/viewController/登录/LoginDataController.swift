//
//  LoginDataController.swift
//  BatterProject
//
//  Created by 王岩 on 2017/7/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class LoginDataController: BaseDataController {
    
    
    
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
                    MyConfig.shared().isLogin = true
                    completionBlock(true, nil)
                }else{
                    completionBlock(false, nil)
                }
                
                
                
            }else{
                //                let result = [
                //                    "code":"0",
                //                    "msg":"成功",
                //                    "data":["userType":"TEACHER",
                //                            "stuList":[["stuId":"1","headUrl":"aa.com"],["stuId":"1","headUrl":"aa.com"]],
                //                            "schoolList":[["schoolId":"1","schoolName":"87中"]],
                //
                //
                //                            ]
                //                    ] as AnyObject
                //
                //                let model = Mapper<LoginModel>().map(JSONObject: result)
                //
                //
                //                let data = NSKeyedArchiver.archivedData(withRootObject: model?.data.toNSObject())
                //                MyConfig.shared().userModel = data
                //                currentUser = model?.data
                completionBlock(false, nil)
            }
            
        }
        
    }
    
    
}

