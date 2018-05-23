//
//  ApplyDataController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/17.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class ApplyDataController: BaseDataController {

    var cellCount = 0
    var model:ApplyModel = ApplyModel()
    var bannerModel = BannerDataModel()
    func getApply(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getApply(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.model = Mapper<ApplyModel>().map(JSONObject: result)!
                self.cellCount = 2
                completionBlock(true, nil)
            }else{
                
                completionBlock(false, nil)
            }
        }
    }
    //获取首页轮播图
    func getCarouselList(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getCarouselList(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                self.bannerModel = Mapper<BannerDataModel>().map(JSONObject: result)!
                completionBlock(true, nil)
            }else{
                
                completionBlock(false, nil)
            }
        }
    }

}
