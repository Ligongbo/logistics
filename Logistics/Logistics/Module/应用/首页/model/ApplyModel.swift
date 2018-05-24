//
//  ApplyModel.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/17.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit
import ObjectMapper

class ApplyModel: BaseModel {
    var data:Array<ApplyToolModel> = [ApplyToolModel]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data <- map["data"]
    }
}

class ApplyToolModel: BaseModel {
    var orderId:String = ""         //订单id
    var tradingHour:String = ""     //交易时间
    var senderName  = ""                //发送方
    var sendCity:String = ""        //发货市
    var sendDistrict = ""           //发货区
    var receiveCity = ""            //收货市
    var receiveDistrict = ""        //收货区
    var receiverName = ""           //收货方
    var carInformation = ""         //车辆信息
    
    override func mapping(map: Map) {
        orderId <- map["orderId"]
        tradingHour <- map["tradingHour"]
        senderName <- map["senderName"]
        sendCity <- map["sendCity"]
        sendDistrict <- map["sendDistrict"]
        receiveCity <- map["receiveCity"]
        receiveDistrict <- map["receiveDistrict"]
        receiverName <- map["receiverName"]
        carInformation <- map["carInformation"]
    }
}
