//
//  MSVersionManager.swift
//  HandleSchool
//
//  Created by 李琪 on 16/5/31.
//  Copyright © 2016年 Huihai. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


var sharedVersionManager:MSVersionManager?
class MSVersionManager {
    var reachability:Reachability!
    let HSHTTPAppStoreServerID = "HSAPPStoreID"
    
    class func sharedInstance() -> MSVersionManager{
        if sharedVersionManager == nil{
            sharedVersionManager = MSVersionManager()
        }
        return sharedVersionManager!
    }
    
    init() {
        reachability = Reachability.forInternetConnection()
    }
    
    func getLocalVersion() -> String{
        return appBuildVersion
    }
    
    func checkAppStoreVersion(){
        LHHTTPClient.sharedClientWithIdentifier(HSHTTPAppStoreServerID).basePath = "http://itunes.apple.com/"
        LHHTTPClient.sharedClientWithIdentifier(HSHTTPAppStoreServerID).GET("lookup", parameters: ["id":MyAppID], verson:nil) { (requestSucceed, response, error) -> Void in
            
            //请求异常时处理方式
            if error != nil{
                return
            }
            
            if (response as? String)?.jsonValue() as? NSDictionary == nil{
                return
            }
            
            let jsonData = ((response as AnyObject) as? String)?.jsonValue() as! NSDictionary
            let infoArray = jsonData["results"] as! NSArray
            
            
            if (infoArray.count > 0) {
                if infoArray[0] is NSDictionary{
                    let releaseInfo = infoArray[0] as! NSDictionary
                    let versionInfo = HSAppVersionInfo()
                    versionInfo.version = releaseInfo["version"] as! String
                    versionInfo.trackViewUrl = releaseInfo["trackViewUrl"] as! String
                    
                    
                    self.reachability.startNotifier()
                    var alertMessage = ""
                    if self.reachability.currentReachabilityStatus() == NetworkStatus.ReachableViaWiFi{
                        alertMessage = "有新的版本更新，是否前往更新?"
                    }
                    else{
                        alertMessage = "有新的版本更新，当前网络为移动网络，更新需要消耗流量，是否前往更新?"
                    }
                    self.reachability.stopNotifier()
                    
                    if self.shouldUpdateApp(versionInfo.version){
                        LHAlertView.showAlertWithTitle("更新", msg: alertMessage, confirmButtonTitle: "更新", cancelButtonTitle: "关闭", completionBlock: {
                            UIApplication.shared.openURL(URL(string: versionInfo.trackViewUrl)!)
                        }, cancelBlock: {
                            exit(0)
                        })
                    }
                }
            }
            
            
        }
        
    }
    
    func shouldUpdateApp(_ newVersion:String) -> Bool{
        let newVersionArray = newVersion.components(separatedBy: ".")
        let localVersionArray = appBuildVersion.components(separatedBy: ".")
        
        for i in 0..<newVersionArray.count{
            if Int(localVersionArray[i]) > Int(newVersionArray[i]){
                return false
            }
            if Int(localVersionArray[i]) == Int(newVersionArray[i]){
                continue
            }
            if Int(localVersionArray[i]) < Int(newVersionArray[i]){
                return true
            }
        }
        return false
    }
    
    
}


class HSAppVersionInfo {
    var version = ""
    var trackViewUrl = ""
}
