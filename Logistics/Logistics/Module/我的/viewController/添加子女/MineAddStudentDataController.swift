//
//  MineAddStudentDataController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/4.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class MineAddStudentDataController: BaseDataController {
    var model = StudentDataModel()
    //家长获取要添加的子女
    func getStuListByAccount(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getStuListByAccount(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.model = Mapper<StudentDataModel>().map(JSONObject: result)!
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }

}
