//
//  ScheduleTeacherDataModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/8.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class ScheduleTeacherDataModel: BaseModel {
    var data:Array<ScheduleTeacherModel> = [ScheduleTeacherModel]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
    
}
class ScheduleTeacherModel: BaseModel {
    var section = ""
    var gradeClass = ""//教师用
    var teaName = "" //学生家长用
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        section    <- map["section"]
        gradeClass    <- map["gradeClass"]
        teaName    <- map["teaName"]
    }
    
}
