//
//  BannerDataModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/13.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class BannerDataModel: BaseModel {
    var data:Array<BannerItemModel> = [BannerItemModel]()
    
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}

class BannerItemModel: BaseModel {
    var title = ""
    var picUrl = ""
    var jumpUrl = ""
    
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        title    <- map["title"]
        picUrl    <- map["picUrl"]
        jumpUrl    <- map["jumpUrl"]
    }
}
