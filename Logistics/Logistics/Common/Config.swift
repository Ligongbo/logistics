//
//  Config.swift
//  MiddleSchool2_teacher
//
//  Created by 李琪 on 2017/5/4.
//  Copyright © 2017年 李琪. All rights reserved.
//

var isDebugging = false
var NetIsDebugging = false

//屏幕尺寸相关
let ScreenWidth:CGFloat = UIScreen.main.bounds.size.width;
let ScreenHeight:CGFloat = UIScreen.main.bounds.size.height


//程序相关
let MyAppID:String = "" //appId
let ProductId:String = "a131be5242a311e8b50500505694781a"//
let GetAreaServerClientIdentifier = "GetAreaServerClientIdentifier"

//默认图片
let defaultImage = UIImage.loadImage("image-placeholder")
let defaultFullScreenImage = UIImage.loadImage("image-fullScreen-placeholder")
let defaultPortraitImage = UIImage.loadImage("defaultPortrait")

//存储当前登录用户信息
var currentUser:UserModel! = UserModel()

//工具包ID
enum ToolIdType : String{
    
    case researchLearn = "hiResearchLearnJl"//学业成果
    case clubActivity = "hiClubActivitiesJl"//社团活动
    case realRecord = "hiGeneralActJl"//写实记录
    case metalHealth = "hiMentalHealthJl"//心理健康测试
    case growthPlan = "hiGrowPlanJl"//成长规划
    case comment = "hiCommentTermJl"//学期评语
    case dailyShow = "hiDailyShowJl"//日常表现评价
    case hiHonorJl = "hiHonorJl"//荣誉信息
}





enum DirectionType:Int{
    case first = 0
    case top = 1
    case down = 2
    
}
enum SystemType:String{
    case primarySchool = "1"//小学
    case middleSchool3 = "2"//三代中学
    case highSchool = "3"//高中
    case arrangingSystem = "4"//排课系统
    case BureauSystem = "5"//教育局系统
    case middleSchool2 = "6"//二代中学
}

//系统相关
let systemVersion:Float = Float(UIDevice.current.systemVersion)!    //系统版本号
let appBuildVersion:String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String //build版本号


let defaultIntValue:Int = 0
let defaultInt8Value:Int8 = 0
let defaultInt16Value:Int16 = 0
let defaultInt32Value:Int32 = 0
let defaultInt64Value:Int64 = 0
let defaultFloatValue:Float = 0
let defaultDoubleValue:Double = 0
let defaultString = ""

let defaultTableViewSectionTitlesArray = ["#",
                                          "A","B","C","D","E","F","G",
                                          "H","I","J","K","L","M","N",
                                          "O","P","Q",    "R","S","T",
                                          "U","V","W",    "X","Y","Z"
                                          ]
//网络请求
//let HostAddress = "http://118.89.242.54:8090/songsongTown/"
//基础接口
//let GetAreaListHost = "http://192.168.13.3/centsvc/mobile/"      //开发获取区域列表接口地址
//let GetAreaListHost = "http://show.huihaiedu.cn/base_service/mobile/" //演示获取区域列表接口地址
let GetAreaListHost = "http://app.huihaiedu.cn/base_service/mobile/"      //生产获取区域列表接口地址
//用户隐私协议
let StaticProtocoHtml = "resources/common/user_agreement.html"

//正式服务器
//var HostAddress = "http://high.huihaiedu.cn/high_web/"


//var FileServerAddress = "http://high.huihaiedu.cn/fileserver/upload_files_mobile"// 上传文件
//var FileAccessHost = "http://high.huihaiedu.cn/" // 显示文件
//var BaseImgUrl = "http://high.huihaiedu.cn/eedu_base/"//础图片地址
//var Protocolhtml = "http://high.huihaiedu.cn/static/resources/user_agreement.html"//用户隐私协议

//演式服务器
//var HostAddress = "http://high.demo.huihaiedu.cn:8080/high_web/"


//var FileServerAddress = "http://high.demo.huihaiedu.cn:8080/fileserver/upload_files_mobile"// 上传文件
//var FileAccessHost = "http://high.demo.huihaiedu.cn:8080/" // 显示文件
//var BaseImgUrl = "http://high.demo.huihaiedu.cn:8080/eedu_base/"//础图片地址
//var Protocolhtml = "http://high.demo.huihaiedu.cn:8080/static/resources/user_agreement.html"//用户隐私协议
//测试服务器
var HostAddress = "http://192.168.13.2/high_web/111"



var FileServerAddress = "http://192.168.13.2/fileserver/upload_files_mobile"// 上传文件
var FileAccessHost = "http://192.168.13.2/" // 显示文件
var BaseImgUrl = "http://192.168.13.2/eedu_base/"//础图片地址
var Protocolhtml = "http://192.168.13.2/eedu_high/static/html/user_agreement.html"//用户隐私协议


//开发时服务器
//let HostAddress = "http://192.168.11.2/high_web/"

//let FileServerAddress = "http://192.168.11.2/fileserver/upload_files_mobile"// 上传文件
//let FileAccessHost = "http://192.168.11.2/" // 显示文件
//let BaseImgUrl = "http://192.168.11.2/eedu_base/"//础图片地址
//let Protocolhtml = "http://high.demo.huihaiedu.cn/eedu_high/static/html/user_agreement.html"//用户隐私协议
//姜红雨
//let HostAddress = "http://192.168.9.152:8190/high_web/"


//var FileServerAddress = "http://192.168.13.2/fileserver/upload_files_mobile"// 上传文件
//var FileAccessHost = "http://192.168.13.2/" // 显示文件
//var BaseImgUrl = "http://192.168.13.2/eedu_base/"//础图片地址
//let Protocolhtml = "http://192.168.13.2/eedu_high/static/html/user_agreement.html"//用户隐私协议






let HostAddressSandBoxKey = "hostAddressSandBoxKey"
let AreaIdSandBoxKey = "areaIdSandBoxKey"
let AreaNameSandBoxKey = "areaNameSandBoxKey"
let FileServerClientIdentifier = "FileServerClientIdentifier"
let BaseServerClientIdentifier = "BaseServerClientIdentifier"
let ToolKitServerClientIdentifier = "ToolKitServerClientIdentifier"


var areaId:String{
    get{
        let AreaIdInSandBox = UserDefaults.standard.object(forKey: AreaIdSandBoxKey)
        return AreaIdInSandBox == nil ? "" : AreaIdInSandBox as! String
    }
}

var areaName:String{
    get{
        let AreaNameInSandBox = UserDefaults.standard.object(forKey: AreaNameSandBoxKey)
        return AreaNameInSandBox == nil ? "" : AreaNameInSandBox as! String
    }
}
