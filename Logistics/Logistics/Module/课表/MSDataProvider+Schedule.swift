//
//  MSDataProvider+Schedule.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/8.
//  Copyright © 2017年 MR. All rights reserved.
//

import Foundation
extension MSDataProvider{
    
    //教师课表（教师任课表）
    class func courseTeacher(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate,clientIdentifier: ToolKitServerClientIdentifier, path: "course/teacher", withParams: parameter, verson: nil, completionBlock: completionBlock)
        
    }

    //学生课表（班级课表）
    class func courseStudent(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate,clientIdentifier: ToolKitServerClientIdentifier, path: "course/student", withParams: parameter, verson: nil, completionBlock: completionBlock)
        
    }

    
    
}
