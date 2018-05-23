//
//  SchoolDataModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/25.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class SchoolDataModel: BaseModel {
    var data:Array<SchoolModel> = [SchoolModel]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}

