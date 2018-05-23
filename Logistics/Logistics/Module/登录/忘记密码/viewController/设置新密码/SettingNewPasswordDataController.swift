//
//  SettingNewPasswordDataController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/8.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class SettingNewPasswordDataController: BaseDataController {
    //找回密码
    func authFindPwd(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.authFindPwd(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
}
