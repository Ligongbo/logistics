//
//  MineSelectStudentDataController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/19.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class MineSelectStudentDataController: BaseDataController {
    var model = StudentAddedDataModel()
    //家长获取已添加的子女
    func getStuListById(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getStuListById(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.model = Mapper<StudentAddedDataModel>().map(JSONObject: result)!
               
                
                
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
    
    //选择子女
    func selectStu(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.selectStu(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
               
                
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
}
