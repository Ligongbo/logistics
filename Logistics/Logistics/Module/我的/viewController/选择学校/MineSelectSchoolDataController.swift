//
//  MineSelectSchoolDataController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/19.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class MineSelectSchoolDataController: BaseDataController {
    var model = SchoolDataModel()
    //获取学校
    func getSchoolList(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getSchoolList(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.model = Mapper<SchoolDataModel>().map(JSONObject: result)!
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
    //选择学校
    func selectSchool(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.selectSchool(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }

}
