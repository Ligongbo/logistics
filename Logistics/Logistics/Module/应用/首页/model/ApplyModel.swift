//
//  ApplyModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/17.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper


class ApplyModel: BaseModel {
    
    var data:Array<ApplyToolModel> = [ApplyToolModel]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}


class ApplyToolModel: BaseModel {
    var toolId:ToolIdType!  //工具包id
    var text:String! //工具包名称
    var icon:String! //工具包图标路径
    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        toolId      <- map["toolId"]
        text       <- map["text"]
        icon       <- map["icon"]
    }
    
}
