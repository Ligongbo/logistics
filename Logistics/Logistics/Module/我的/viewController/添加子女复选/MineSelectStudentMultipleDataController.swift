//
//  MineSelectStudentMultipleDataController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/4.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class MineSelectStudentMultipleDataController: BaseDataController {
    var block:AddStudentBlock?
    var stuArray:Array<StudentItemModel> = [StudentItemModel]()
    var bindUserId = ""
    
    
    func update(dic:NSMutableDictionary){
        if dic["block"] != nil{
            block = dic["block"] as! AddStudentBlock
        }
        if dic["stuArray"] != nil{
            stuArray = dic["stuArray"] as! Array<StudentItemModel>
        }
        if dic["bindUserId"] != nil{
            bindUserId = dic["bindUserId"] as! String
        }
    }
    //添加账号绑定
    func authAddBindAccount(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.authAddBindAccount(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                
                
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
   
}
