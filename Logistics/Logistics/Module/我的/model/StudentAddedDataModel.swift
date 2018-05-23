//
//  StudentAddedDataModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/11.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
//家长获取已添加的子女
class StudentAddedDataModel: BaseModel {
    var data:Array<StudentItemModel> = [StudentItemModel]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
