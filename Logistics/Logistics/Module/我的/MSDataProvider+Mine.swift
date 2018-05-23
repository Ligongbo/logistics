//
//  MSDataProvider+Login.swift
//  BatterProject
//
//  Created by 王岩 on 2017/7/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import Foundation

extension MSDataProvider{
    //退出登陆
    class func logout(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "auth/logout", withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //获取学校
    class func getSchoolList(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, clientIdentifier: ToolKitServerClientIdentifier, path: "getSchoolList",withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //选择学校
    class func selectSchool(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, clientIdentifier: ToolKitServerClientIdentifier, path: "selectSchool",withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //修改密码
    class func updatePwd(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        
        LHHttpDataProvider.postDataForDelegate(delegate, path: "auth/updatePwd",withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //验证原绑定手机验证码
    class func checkUserVerCode(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, path: "common/checkUserVerCode",withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //验证原绑定手机验证码
    class func myAccount(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){

        LHHttpDataProvider.postDataForDelegate(delegate, clientIdentifier: ToolKitServerClientIdentifier,path: "myAccount",withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //上传头像路径
    class func uploadHeadUrl(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, clientIdentifier: ToolKitServerClientIdentifier,path: "uploadHead",withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //家长获取已添加的子女
    class func getStuListById(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, clientIdentifier: ToolKitServerClientIdentifier,path: "getStuListById",withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //家长获取要添加的子女
    class func getStuListByAccount(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, clientIdentifier: ToolKitServerClientIdentifier,path: "getStuListByAccount",withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //选择子女
    class func selectStu(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, clientIdentifier: ToolKitServerClientIdentifier,path: "auth/switchStu",withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    //添加账号绑定
    class func authAddBindAccount(delegate:UIViewController, parameter:NSMutableDictionary, completionBlock:@escaping LHHTTPResultJsonHandler){
        LHHttpDataProvider.postDataForDelegate(delegate, clientIdentifier: ToolKitServerClientIdentifier,path: "auth/addBindAccount",withParams: parameter, verson: nil, completionBlock: completionBlock)
    }
    
    
    
}
