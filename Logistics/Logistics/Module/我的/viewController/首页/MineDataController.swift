//
//  MineDataController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/25.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class MineDataController: BaseDataController {
    var model:MyAccountDataModel = MyAccountDataModel()
    //退出登陆
    func logout(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.logout(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                
                completionBlock(true, nil)
            }else{
                completionBlock(true, nil)
            }
        }
    }
    //我的
    func myAccount(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.myAccount(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.model = Mapper<MyAccountDataModel>().map(JSONObject: result)!
                
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
    
}
