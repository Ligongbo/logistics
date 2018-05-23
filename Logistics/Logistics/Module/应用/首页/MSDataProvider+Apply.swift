//
//  MSDataProvider+Apply.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/17.
//  Copyright © 2017年 MR. All rights reserved.
//

import Foundation
extension MSDataProvider{
    //首页接口
    class func getApply(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, clientIdentifier: ToolKitServerClientIdentifier,path: "getAppList", withParams: parameter, verson: nil, completionBlock: completionBlock)
        
    }
    
    
    
    //获取首页轮播图
    class func getCarouselList(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, clientIdentifier: ToolKitServerClientIdentifier,path: "getCarouselList", withParams: parameter, verson: nil, completionBlock: completionBlock)
        
    }
    
}
