//
//  ParentRegisterDataController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/9/7.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class ParentRegisterDataController: BaseDataController {

    //账号绑定校验验证码
    func commonCheckVerCodeByBindAccount(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.commonCheckVerCodeByBindAccount(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
}
