//
//  StudentDataModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/28.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

import ObjectMapper
class StudentDataModel: BaseModel {
    var data:StudentListModel = StudentListModel()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data    <- map["data"]
    }
}
class StudentListModel:BaseModel{
    var userType:UserType = .error
    var userId = ""
    var userName = ""
    var studentList:Array<StudentItemModel> = [StudentItemModel]()

    
    
    
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        userType    <- map["userType"]
        userId    <- map["userId"]
        userName    <- map["userName"]
        studentList    <- map["studentList"]
        
    }

}
class StudentItemModel:BaseStudentsModel{
    
    var headUrl = ""
    var userType:UserType = .error
    var className = ""
    var schId = ""
    var gradeName = ""
    var schoolName = ""
    var gradeClassName = ""
    var classId = ""
    var gradeId = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        headUrl    <- map["headUrl"]
        userType    <- map["userType"]
        className    <- map["className"]
        schId    <- (map["schId"],transfromOfCustomFunction())
        gradeName    <- map["gradeName"]
        schoolName    <- map["schoolName"]
        gradeClassName    <- map["gradeClassName"]
        classId    <- (map["classId"],transfromOfCustomFunction())
        gradeId    <- (map["gradeId"],transfromOfCustomFunction())
        name <- map["name"]
        id <- (map["id"],transfromOfCustomFunction())
        
    }
}
