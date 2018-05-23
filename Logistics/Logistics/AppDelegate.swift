//
//  AppDelegate.swift
//  MiddleSchool2_teacher
//
//  Created by 李琪 on 2017/5/2.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit
import ObjectMapper
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    //广告专用
//    var splash:BaiduMobAdSplash?
//    var button:UIButton!
//    var timer: Timer?
//    var customSplashView:UIView!
//    var timeInterval = 3
    

    
    let appKey = "24575782"
    let appSecret = "ff38457dc8358b0b38f8fc284f2464c1"
    var index = 0 //获取deviceId的初始次数
    var getDevieceSuccess = false //获取deviceId是否成功
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //创建window
        loadWindow()
        
        let loginVC = LanchImageViewController(nibName: "LanchImageViewController", bundle: nil)
        window?.rootViewController = loginVC
        window?.makeKeyAndVisible()
        //初始化网络请求组件
        initBaseClient()
        
//        //根据应用版本及登录状态跳转至相应页面
//        performToTargetVCAccordingToVersionAndLoginStatus()
        
        //获取配置接口
        
        if !String.isNilOrEmpty(areaId){
            getConfig()
        }else{
            //根据应用版本及登录状态跳转至相应页面
            self.performToTargetVCAccordingToVersionAndLoginStatus()
        }
        
        //隐藏键盘工具条
        keyManager()
        

        
        
        
        
        return true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        MSVersionManager.sharedInstance().checkAppStoreVersion()
        
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Receive one notification.")
        let aps = userInfo["aps"] as! [AnyHashable : Any]
        let alert = aps["alert"] ?? "none"
        let badge = aps["badge"] ?? 0
        let sound = aps["sound"] ?? "none"
        let extras = userInfo["Extras"]
        print("Notification, alert: \(alert), badge: \(badge), sound: \(sound), extras: \(extras).")
        
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
    }
    
    func getConfig(){
        
        HostAddress = UserDefaults.standard.object(forKey: HostAddressSandBoxKey) as! String
        LHHTTPClient.sharedClient().basePath = HostAddress
        LHHTTPClient.sharedClientWithIdentifier(ToolKitServerClientIdentifier).basePath = HostAddress
        LHHTTPClient.sharedClientWithIdentifier(ToolKitServerClientIdentifier).POST("getMobileConfig", parameters: nil, verson: nil, autoAlert: false) { (isSucceed, response, error) in
            //请求异常时处理方式
            
            if error != nil{
                if error!.code == -1001{
                    LHAlertView.showTipAlertWithTitle("当前网络不给力，请检查网络")
                    return
                }else if error!.code == -1004 {
                    
                    LHAlertView.showTipAlertWithTitle("无法连接服务器")
                    return
                }else if(error!.code == -1009){
                    
                    LHAlertView.showTipAlertWithTitle("网络未连接")
                    return
                }else {
                    
                    LHAlertView.showTipAlertWithTitle("数据请求失败")
                    return
                }
            }
            let myBaseModel = Mapper<BaseModel>().map(JSONObject: response)
            if myBaseModel?.code == "2"{
            }else if myBaseModel?.code != "0"{
                LHAlertView.showTipAlertWithTitle((myBaseModel?.msg)!)
            }
            
            if isSucceed{
                let model = Mapper<ConfigDataModel>().map(JSONObject: response)
                if model != nil{

                    FileServerAddress = model!.data.file_upload_url
                    FileAccessHost = model!.data.file_access_host
                    if FileAccessHost.hasSuffix("/"){
                        
                    }else{
                        FileAccessHost = FileAccessHost + "/"
                    }
                    BaseImgUrl = model!.data.base_img_url
                    if BaseImgUrl.hasSuffix("/"){
                        
                    }else{
                        BaseImgUrl = BaseImgUrl + "/"
                    }
                    MyConfig.shared().projectNameHigh = model!.data.high_project_name
                     MyConfig.shared().projectNameBase = model!.data.base_project_name

                    //TODO 文件上传
                    //                    FileServerAddress = "http://192.168.11.119:8080/fileserver/upload_file"
                    //                    FileAccessHost = "http://192.168.11.119:8081/"
                    Protocolhtml = FileAccessHost + StaticProtocoHtml
                    LHHTTPClient.sharedClientWithIdentifier(FileServerClientIdentifier).basePath = FileServerAddress
                    //根据应用版本及登录状态跳转至相应页面
                    self.performToTargetVCAccordingToVersionAndLoginStatus()
                }
            }else{
                
            }
        }
    }
    
    
}

