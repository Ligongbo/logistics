//
//  SelectMultipleStudentDataController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/22.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper
class SelectMultipleStudentDataController: BaseDataController {

    var model:SelectMultipleStudentDataModel = SelectMultipleStudentDataModel()

    var gradeId = ""
    var calssId = ""
    var oldSelectArray:Array<SelectMultipleStudentModel> = [SelectMultipleStudentModel]()//传过来的已选择学生
    var selectArray:Array<SelectMultipleStudentModel>{//已选择的学生
        get{
            var tempArray = [SelectMultipleStudentModel]()
            for group in groupedStudents{
                for student in group{
                    if (student.isSelected == true){
                        tempArray.append(student)
                    }
                }
            }
            
            return tempArray
        }
    }
    var students:Array<SelectMultipleStudentModel> = [SelectMultipleStudentModel]()
    var sectionTitles:Array<String> = [String]()
    var groupedStudents:Array<Array<SelectMultipleStudentModel>> = [[SelectMultipleStudentModel]]()   //按首字母分组后的学生数组,首字母与sectionTitles对应
    var selectStudentsBlock:SelectStudentsBlock?
    func update(dic:NSMutableDictionary){
        gradeId = dic["gradeId"] as! String
        calssId = dic["calssId"] as! String
        oldSelectArray = dic["oldSelectArray"] as! Array<SelectMultipleStudentModel>
        selectStudentsBlock = dic["selectStudentsBlock"] as? SelectStudentsBlock
    }
    //获取学生列表
    func getStudents(parameter:NSMutableDictionary,completionBlock:@escaping RequestCompleteBlock){
        MSDataProvider.getStudents(delegate: self.delegate!, parameter: parameter) { (isSuccess,result) in

            if isSuccess{
                self.students.removeAll()
                self.groupedStudents.removeAll()
                self.model = Mapper<SelectMultipleStudentDataModel>().map(JSONObject: result)!
                
                self.students = self.model.data
                if self.oldSelectArray.count > 0{
                    for student in self.students {
                        for oldStudent in self.oldSelectArray{
                            if student.id == oldStudent.id{
                                student.isSelected = true
                            }
                        }
                    }
                }
                self.sortStudents()
                
                completionBlock(true, nil)
            }else{
//                self.students.removeAll()
//                self.groupedStudents.removeAll()
//                let result = [
//                    "code":"1",
//                    "msg":"成功",
//                    "data":[
//                        "list":[
//                            ["id":"1", "studentNo":"120801", "name":"李白"],
//                            ["id":"", "studentNo":"120802", "name":"黄晓明"],
//                            ["id":"3", "studentNo":"120803", "name":"张三"],
//                            ["id":"4", "studentNo":"120804", "name":"成龙"],
//                            ["id":"5", "studentNo":"120805", "name":"斑马"],
//                            ["id":"6", "studentNo":"120806", "name":"盖伦"],
//                            ["id":"7", "studentNo":"120807", "name":"幻刺"],
//                            ["id":"8", "studentNo":"120808", "name":"暗影猎手"],
//                            ["id":"9", "studentNo":"120809", "name":"小白"],
//                            ["id":"10", "studentNo":"120810", "name":"小明"],
//                            ["id":"11", "studentNo":"120811", "name":"千珏"],
//                            ["id":"12", "studentNo":"120812", "name":"黄家驹"],
//                            ["id":"13", "studentNo":"120813", "name":"鼠标"],
//                            ["id":"14", "studentNo":"120814", "name":"hello"],
//                            ["id":"15", "studentNo":"120815", "name":"多美丽"],
//                            ["id":"16", "studentNo":"120816", "name":"肯德基"],
//                            ["id":"17", "studentNo":"120817", "name":"##"],
//                        ]
//                    ]
//                    ] as AnyObject
//                
//             
//                self.model = Mapper<BaseStudentsDataModel>().map(JSONObject: result)!
//                
//                self.students = self.model.data.students
//                if self.oldSelectArray.count > 0{
//                    for student in self.students {
//                        for oldStudent in self.oldSelectArray{
//                            if student.id == oldStudent.id{
//                                student.isSelected = true
//                            }
//                        }
//                    }
//                }
//                self.sortStudents()
                completionBlock(false, nil)

            }
            
        }
    }

    
    fileprivate func sortStudents(){
        let tempStudents = NSMutableArray()
        for student in students{
            tempStudents.add(student.toNSObject())
        }
        
        sectionTitles = BMChineseSort.index(with: tempStudents as! [Any], key: "name") as! Array<String>
        
        let tempGroups:NSMutableArray = BMChineseSort.sortObjectArray(tempStudents as! [Any], key: "name")
        for tempGroup in tempGroups{
            var group = [SelectMultipleStudentModel]()
            for item in tempGroup as! NSArray{
                group.append((item as! ObjcSelectMultipleStudentModel).toAnyObject())
            }
            groupedStudents.append(group)
        }
        
        students.removeAll()
        for group in groupedStudents{
            for student in group{
                students.append(student)
            }
        }
    }
    
}
