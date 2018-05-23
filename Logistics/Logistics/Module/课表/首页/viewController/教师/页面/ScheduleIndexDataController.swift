//
//  ScheduleIndexDataController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/8.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class ScheduleIndexDataController: BaseDataController {

    var model = ScheduleTeacherDataModel()
    
    //教师课表（教师任课表）
    func courseTeacher(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.courseTeacher(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.model = Mapper<ScheduleTeacherDataModel>().map(JSONObject: result)!
//                if self.model.data.count > 0{
//                    for i in 0..<10 {
//                        self.model.data.append(self.model.data[0])
//                    }
//                }
                
                
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
    //学生课表（班级课表）
    func courseStudent(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.courseStudent(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.model = Mapper<ScheduleTeacherDataModel>().map(JSONObject: result)!
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
}
