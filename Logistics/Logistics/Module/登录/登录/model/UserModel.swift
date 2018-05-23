//
//  UserModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/18.
//  Copyright © 2017年 MR. All rights reserved.
//

import Foundation
import ObjectMapper

enum UserType:Int{
    case error = 0
    case teacher = 1
    case student = 2
    case parent = 3
}
class UserModel: BaseModel {
    //id存放学生家长的学生id
    var isNeedBindTel:String = ""//是否需要绑定手机号 1:是 0:否
    var userType:UserType = .error  //用户角色
    var token:String = "" //认证标识
    var isSelectStu:String = "" //家长需要的字段；是否选择子女（0未选择1已选择(只有在注册时选择1个孩子的时候才返回1，还有单独选择子女的时候返回1)）
    var isSelectSch:String = "" //教师需要的字段
    var stuList:Array<StudentModel> = [StudentModel]() //给家长用的
    var schoolList:Array<SchoolModel> = [SchoolModel]() //教师用到的；
    var headUrl:String = "" //用户头像
    var selectStuId:String = "" //家长用到的；选择的学生ID
    var selectSchId:String = "" //教师用到的；选择的学校ID
    var isBindPhone:String = "" //是否绑定手机
    var gradeId:String = "" //年级id
    var orgId = "" //结构Id
    var selectStuSchId = ""//家长用到的；选择的学生的学校ID
    var schId = ""//学生的学校id  //存放学生家长的学校id
    var classId = ""//classId
    var userId = "" //用户id
    var termId = "" //学期id
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        token      <- map["token"]
        
        userType       <- map["userType"]
        isSelectStu       <- map["isSelectStu"]
        isSelectSch       <- map["isSelectSch"]
        stuList       <- map["stuList"]
        schoolList       <- map["schoolList"]
        headUrl       <- map["headUrl"]
        selectStuId       <- (map["selectStuId"],transfromOfCustomFunction())
        selectSchId       <- (map["selectSchId"],transfromOfCustomFunction())
        isBindPhone       <- map["isBindPhone"]
        gradeId       <- (map["gradeId"],transfromOfCustomFunction())
        isNeedBindTel       <- map["isNeedBindTel"]
//        orgId       <- (map["orgId"],transfromOfCustomFunction())
        orgId       <- map["orgId"]
        selectStuSchId       <- (map["selectStuSchId"],transfromOfCustomFunction())
        schId       <- (map["schId"],transfromOfCustomFunction())
        classId       <- (map["classId"],transfromOfCustomFunction())
        userId       <- (map["id"],transfromOfCustomFunction())
        termId       <- (map["termId"],transfromOfCustomFunction())
        
        
        
        
    }
    func toNSObject() -> UserNSObjectModel{
        let newObj = UserNSObjectModel()
        newObj.id = self.id
        newObj.name = self.name
        newObj.token = self.token
        newObj.userType = self.userType
        newObj.isSelectStu = self.isSelectStu
        newObj.isSelectSch = self.isSelectSch
        newObj.headUrl = self.headUrl
        newObj.selectStuId = self.selectStuId
        newObj.selectSchId = self.selectSchId
        newObj.isBindPhone = self.isBindPhone
        newObj.gradeId = self.gradeId
        newObj.stuList = [StudentNSObjectModel]()
        newObj.schoolList = [SchoolNSObjectModel]()
        newObj.isNeedBindTel = self.isNeedBindTel
        newObj.orgId = self.orgId
        newObj.selectStuSchId = self.selectStuSchId
        newObj.schId = self.schId
        newObj.classId = self.classId
        newObj.userId = self.userId
        newObj.termId = self.termId
        
        for item in self.stuList{
            let studentNSObjectModel = StudentNSObjectModel()
            studentNSObjectModel.stuId = item.stuId
            studentNSObjectModel.headUrl = item.headUrl
            studentNSObjectModel.stuName = item.stuName
            studentNSObjectModel.school = item.school
            studentNSObjectModel.gradeClassName = item.gradeClassName
            newObj.stuList.append(studentNSObjectModel)
        }
        
        for item in self.schoolList{
            
            let schoolNSObjectModel = SchoolNSObjectModel()
            schoolNSObjectModel.schoolId = item.schoolId
            schoolNSObjectModel.schoolName = item.schoolName
            
            newObj.schoolList.append(schoolNSObjectModel)
        }

        
        return newObj
    }
    
    
    
}
class UserNSObjectModel: NSObject,NSCoding {
    var id = ""
    var name = ""
    var isNeedBindTel:String = ""//是否需要绑定手机号 1:是 0:否
    var userType:UserType = .error //用户角色
    var token:String = "" //认证标识
    var isSelectStu:String = "" //家长需要的字段；是否选择子女（0未选择1已选择(只有在注册时选择1个孩子的时候才返回1，还有单独选择子女的时候返回1)）
    var isSelectSch:String = "" //教师需要的字段
    var stuList:Array<StudentNSObjectModel> = [StudentNSObjectModel]() //给家长用的
    var schoolList:Array<SchoolNSObjectModel> = [SchoolNSObjectModel]() //教师用到的；
    var headUrl:String = "" //用户头像
    var selectStuId:String = "" //家长用到的；选择的学生ID
    var selectSchId:String = "" //教师用到的；选择的学校ID
    var isBindPhone:String = "" //是否绑定手机
    var gradeId:String = "" //年级id
    var orgId = "" //结构Id
    var selectStuSchId = ""//家长用到的；选择的学生的学校ID
    var schId = ""//学生的学校id
    var classId = ""
    var userId = ""
    var termId = ""
    override init() {
        super.init()
    }
    
    
    func toAnyObject() -> UserModel{
        let newObj = UserModel()
        newObj.id = self.id
        newObj.name = self.name
        newObj.token = self.token
        newObj.userType = self.userType
        newObj.isSelectStu = self.isSelectStu
        newObj.isSelectSch = self.isSelectSch
        newObj.headUrl = self.headUrl
        newObj.selectStuId = self.selectStuId
        newObj.selectSchId = self.selectSchId
        newObj.isBindPhone = self.isBindPhone
        newObj.gradeId = self.gradeId
        newObj.stuList = [StudentModel]()
        newObj.schoolList = [SchoolModel]()
        newObj.isNeedBindTel = self.isNeedBindTel
        newObj.orgId = self.orgId
        newObj.selectStuSchId = self.selectStuSchId
        newObj.schId = self.schId
        newObj.classId = self.classId
        newObj.userId = self.userId
        newObj.termId = self.termId

        for item in self.stuList{
            let studentModel = StudentModel()
            studentModel.stuId = item.stuId
            studentModel.headUrl = item.headUrl
            studentModel.stuName = item.stuName
            studentModel.school = item.school
            studentModel.gradeClassName = item.gradeClassName
            
            newObj.stuList.append(studentModel)
        }
        
        for item in self.schoolList{
            let schoolModel = SchoolModel()
            schoolModel.schoolId = item.schoolId
            schoolModel.schoolName = item.schoolName
            newObj.schoolList.append(schoolModel)
            
        }
        
        
        
        return newObj
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(token, forKey: "token")
        aCoder.encode(userType.rawValue, forKey: "userType")
        aCoder.encode(isSelectStu, forKey: "isSelectStu")
        aCoder.encode(isSelectSch, forKey: "isSelectSch")
        aCoder.encode(stuList, forKey: "stuList")
        aCoder.encode(schoolList, forKey: "schoolList")
        aCoder.encode(headUrl, forKey: "headUrl")
        aCoder.encode(selectStuId, forKey: "selectStuId")
        aCoder.encode(selectSchId, forKey: "selectSchId")
        aCoder.encode(isBindPhone, forKey: "isBindPhone")
        aCoder.encode(gradeId, forKey: "gradeId")
        aCoder.encode(isNeedBindTel, forKey: "isNeedBindTel")
        aCoder.encode(orgId, forKey: "orgId")
        aCoder.encode(selectStuSchId, forKey: "selectStuSchId")
        aCoder.encode(schId, forKey: "schId")
        aCoder.encode(classId, forKey: "classId")
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(termId, forKey: "termId")
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
//        let tempuserTypeDesc = aDecoder.decodeObject(forKey: "userType") as? Int
        let tempuserTypeDesc:Int32 = aDecoder.decodeInt32(forKey: "userType")
        if tempuserTypeDesc == nil{
            userType = .error
        }
        else{
            let tempType = UserType(rawValue: Int(tempuserTypeDesc))
            userType = tempType == nil ? .error : tempType!
        }
        
        id = aDecoder.decodeObject(forKey: "id") == nil ? "" : aDecoder.decodeObject(forKey: "id") as! String
        name = aDecoder.decodeObject(forKey: "name") == nil ? "" : aDecoder.decodeObject(forKey: "name") as! String
        
        token = aDecoder.decodeObject(forKey: "token") == nil ? "" : aDecoder.decodeObject(forKey: "token") as! String
        isSelectStu = aDecoder.decodeObject(forKey: "isSelectStu") == nil ? "" : aDecoder.decodeObject(forKey: "isSelectStu") as! String
        isSelectSch = aDecoder.decodeObject(forKey: "isSelectSch") == nil ? "" : aDecoder.decodeObject(forKey: "isSelectSch") as! String
        headUrl = aDecoder.decodeObject(forKey: "headUrl") == nil ? "" : aDecoder.decodeObject(forKey: "headUrl") as! String
        selectStuId = aDecoder.decodeObject(forKey: "selectStuId") == nil ? "" : aDecoder.decodeObject(forKey: "selectStuId") as! String
        selectSchId = aDecoder.decodeObject(forKey: "selectSchId") == nil ? "" : aDecoder.decodeObject(forKey: "selectSchId") as! String
        isBindPhone = aDecoder.decodeObject(forKey: "isBindPhone") == nil ? "" : aDecoder.decodeObject(forKey: "isBindPhone") as! String
        stuList = aDecoder.decodeObject(forKey: "stuList") == nil ? [StudentNSObjectModel]() : aDecoder.decodeObject(forKey: "stuList") as! Array<StudentNSObjectModel>
        schoolList = aDecoder.decodeObject(forKey: "schoolList") == nil ? [SchoolNSObjectModel]() :aDecoder.decodeObject(forKey: "schoolList") as! Array<SchoolNSObjectModel>
        orgId = aDecoder.decodeObject(forKey: "orgId") == nil ? "" : aDecoder.decodeObject(forKey: "orgId") as! String
        selectStuSchId = aDecoder.decodeObject(forKey: "selectStuSchId") == nil ? "" : aDecoder.decodeObject(forKey: "selectStuSchId") as! String
        schId = aDecoder.decodeObject(forKey: "schId") == nil ? "" : aDecoder.decodeObject(forKey: "schId") as! String
        classId = aDecoder.decodeObject(forKey: "classId") == nil ? "" : aDecoder.decodeObject(forKey: "classId") as! String
        userId = aDecoder.decodeObject(forKey: "userId") == nil ? "" : aDecoder.decodeObject(forKey: "userId") as! String
        gradeId = aDecoder.decodeObject(forKey: "gradeId") == nil ? "" : aDecoder.decodeObject(forKey: "gradeId") as! String
        termId = aDecoder.decodeObject(forKey: "termId") == nil ? "" : aDecoder.decodeObject(forKey: "termId") as! String

        
        
    }
}

