//
//  BindAccountDataController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/7.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class BindAccountDataController: BaseDataController {

    var model = BindAccountDataModel()
    var phone = ""
    var verCode = ""
    var password = ""
    func update(dic:NSMutableDictionary){
        phone = dic["phone"] as! String
        verCode = dic["verCode"] as! String
        password = dic["password"] as! String
           
        
    }
    //根据用户名密码获取（教师学校列表、家长学生列表）
    func getSchOrStuListByUser(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getSchOrStuListByUser(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.model = Mapper<BindAccountDataModel>().map(JSONObject: result)!
          
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }

}
