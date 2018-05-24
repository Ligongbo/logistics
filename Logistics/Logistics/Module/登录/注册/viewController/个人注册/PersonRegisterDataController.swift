//
//  PersonRegisterDataController.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/23.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class PersonRegisterDataController: BaseDataController {

    var type = ""//company代表企业跳转过来
    //找回密码验证手机验证码
    func commonCheckVerCodeByFindPwd(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.commonCheckVerCodeByFindPwd(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
    
}
