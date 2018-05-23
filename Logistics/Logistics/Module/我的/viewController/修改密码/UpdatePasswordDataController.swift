//
//  UpdatePasswordDataController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/25.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class UpdatePasswordDataController: BaseDataController {
    //修改密码
    func updatePwd(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.updatePwd(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in
            if isSuccess{
                
                completionBlock(true, nil)
            }else{
                completionBlock(false, nil)
            }
        }
    }
}
