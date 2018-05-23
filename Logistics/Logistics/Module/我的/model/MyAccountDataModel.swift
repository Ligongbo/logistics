//
//  MyAccountDataModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/25.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class MyAccountDataModel: BaseModel {
    var data:MyAccountModel = MyAccountModel()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
    
}
class MyAccountModel: BaseModel {
    var headUrl = ""
    var phone = ""
    var schoolName = ""
    var stuName = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        headUrl    <- map["headUrl"]
        phone    <- map["phone"]
        schoolName    <- map["schoolName"]
        stuName    <- map["stuName"]
    }
    
}
