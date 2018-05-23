//
//  ChangeAreaDataController.swift
//  MiddleSchool2
//
//  Created by 李琪 on 2017/12/21.
//  Copyright © 2017年 王岩. All rights reserved.
//

import UIKit
import ObjectMapper
class ChangeAreaDataController: BaseDataController {
    
    var areaList:Array<BaseAreaListModel> = [BaseAreaListModel]()
//    var areaId:String{
//        get{
//            let AreaIdInSandBox = UserDefaults.standard.object(forKey: AreaIdSandBoxKey)
//            return AreaIdInSandBox == nil ? "" : AreaIdInSandBox as! String
//        }
//    }
//    var areaName:String{
//        get{
//            let AreaNameInSandBox = UserDefaults.standard.object(forKey: AreaNameSandBoxKey)
//            return AreaNameInSandBox == nil ? "" : AreaNameInSandBox as! String
//        }
//    }
    
    func getAreaList(completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getAreaList(delegate: self.delegate!) { (isSuccess, result) in
            if isSuccess{
                let model = Mapper<BaseAreaListDataModel>().map(JSONObject: result)
                if model != nil{
                    self.areaList = model!.list
                    let currentId = areaId
                    for item in self.areaList{
                        if item.id == currentId{
                            item.isSelected = true
                            break
                        }
                    }
                    
                    completionBlock(true, nil)
                    return
                }
            }
        }
        
        completionBlock(false, nil)
        
    }
}

