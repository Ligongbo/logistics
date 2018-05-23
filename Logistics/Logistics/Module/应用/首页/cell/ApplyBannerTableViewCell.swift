//
//  ApplyBannerTableViewCell.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/19.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class ApplyBannerTableViewCell: UITableViewCell {

    @IBOutlet var cycleScrollViewContainer: UIView!
    var dataArray:Array<String> = [String]()
    var model:BannerDataModel?
    
    @IBOutlet var advertisingViewBgView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
//    func initCell(dataArray:Array<String>){
//        self.dataArray = dataArray
//        initCycleScrollView()
//    }
    func initCell(model:BannerDataModel){
        if currentUser.userType != .student {
           
        }else{
            
        }
        
        
        if model.data.count > 0{
            self.model = model
            
            for item in model.data{
                dataArray.append(FileAccessHost + item.picUrl)
            }
            initCycleScrollView()
        }
    }
    class func loadCell(_ tableView:UITableView)-> ApplyBannerTableViewCell{
        let cellId:String = "ApplyBannerTableViewCellId"
        var cell:ApplyBannerTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as? ApplyBannerTableViewCell
        
        if (cell == nil || !cell!.isKind(of: ApplyBannerTableViewCell.self)){
            cell = ApplyBannerTableViewCell()
        }
        cell!.selectionStyle = .none
        cell!.textLabel?.textAlignment = .center
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell!
    }
    fileprivate func initCycleScrollView(){
        let cycleScrollView = SDCycleScrollView(frame: CGRect.zero, delegate: nil, placeholderImage: UIImage.loadImage("cycleScrollViewPlaceholder"))!
        cycleScrollView.imageURLStringsGroup = dataArray
        cycleScrollView.autoScrollTimeInterval = 5
        cycleScrollView.drawInView(cycleScrollViewContainer)
        
        cycleScrollView.clickItemOperationBlock = {(index) in
            
        }
        
    }
       
}

