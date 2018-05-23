//
//  BaseModel.swift
//  MiddleSchool2_teacher
//
//  Created by 李琪 on 2017/5/2.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit
import ObjectMapper
class BaseModel: Mappable {
    var id:String = ""
    var name:String = ""
    var code:String?
    var msg:String?
    
    init(){
        
    }
    
    init(id:String, name:String){
        self.id = id
        self.name = name
    }

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- (map["id"],transfromOfCustomFunction())
        name <- map["name"]
        if map["code"].currentValue is String{
            code <- map["code"]
        }else{
            code <- (map["code"],transfromOfCustomFunction())
        }
        msg <- map["msg"]
    }
    //    // 自己定义的某些操作的方法 int转string
    func transfromOfCustomFunction() ->TransformOf< String, Int>{
        return TransformOf< String, Int>.init(fromJSON: { (str) -> String? in
            if str != nil{
                return String(str!)
            }else{
                return ""
            }
            
        }, toJSON: { (str1) -> Int? in
            if str1 == nil{
                return 0
            }
            //转换成json的时候去掉添加的字符串z
            return Int(str1!)
            
        })
    }
    //    // 自己定义的某些操作的方法 double转string
    func transfromDoubleOfCustomFunction() ->TransformOf< String, Double>{
        return TransformOf< String, Double>.init(fromJSON: { (str) -> String? in
            if str != nil{
                return String(str!)
            }else{
                return ""
            }
            
        }, toJSON: { (str1) -> Double? in
            if str1 == nil{
                return 0
            }
            //转换成json的时候去掉添加的字符串z
            return Double(str1!)
        })
    }
    
   
}

