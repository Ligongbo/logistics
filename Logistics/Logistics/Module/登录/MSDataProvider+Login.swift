//
//  MSDataProvider+Login.swift
//  BatterProject
//
//  Created by 王岩 on 2017/7/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import Foundation

extension MSDataProvider{
    //登陆接口
    class func login(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, path: "auth/login", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //第一次绑定手机号
    class func firstBindPhone(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){

        LHHttpDataProvider.postDataForDelegate(delegate, path: "auth/bindPhone", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //获取验证码
    class func getVerCode(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "common/verCode", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //验证原绑定手机验证码
    class func commonCheckVerCodeByBindAccount(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "common/checkVerCodeByBindAccount", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //账号绑定
    class func authBindAccount(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "auth/bindAccount", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //根据用户名密码获取（教师学校列表、家长学生列表）
    class func getSchOrStuListByUser(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate,clientIdentifier: ToolKitServerClientIdentifier, path: "getSchOrStuListByUser", withParams: parameter, verson: nil, completionBlock: completionBlock)
       
    }
    //找回密码
    class func authFindPwd(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate,clientIdentifier: ToolKitServerClientIdentifier, path: "auth/findPwd", withParams: parameter, verson: nil, completionBlock: completionBlock)
        
    }
    //找回密码验证手机验证码
    class func commonCheckVerCodeByFindPwd(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate,clientIdentifier: ToolKitServerClientIdentifier, path: "common/checkVerCodeByFindPwd", withParams: parameter, verson: nil, completionBlock: completionBlock)
        
    }


}
