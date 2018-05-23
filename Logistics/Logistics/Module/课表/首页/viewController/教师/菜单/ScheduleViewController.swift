//
//  ScheduleViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/8/17.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    var currentIndex = 0
    var menuView:MenuView!
    override func viewDidLoad() {
        super.viewDidLoad()

        menuView = MenuView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
       
      
        menuView.contentHeightTab = -49
        menuView.titleArray = ["周一","周二","周三","周四","周五","周六","周日"]
        
        menuView.delegate = self
        let notificationName = Notification.Name(rawValue: "test0")
        NotificationCenter.default.post(name: notificationName, object: self,
                                        userInfo: ["index" : 1])
        self.view.addSubview(menuView)
        resetView()
    }
    func resetView(){
        let date = Date()
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let unitFlag:NSCalendar.Unit = .weekday
        let comps = (calendar as NSCalendar).components(unitFlag, from: date)
        let weekIndex = comps.weekday!
        let index = weekIndex == 0 ? 6 : weekIndex - 2
        menuView.scrollToIndex(index: index)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ScheduleViewController: MenuViewProtocol{
    func menuView(forIndex: Int) -> UIView {
        print("index = \(forIndex)")
        
        let firstVc = UIViewController.loadViewController("ScheduleIndexViewController") as! ScheduleIndexViewController
        firstVc.index = forIndex
        //view必须得有controller管理
        self.addChildViewController(firstVc)
        return firstVc.view
        
        
        
    }
    func menuViewIndex(index: Int) {
        print("btn = \(index)")
        if currentIndex != index{
            let notificationName = Notification.Name(rawValue: "test\(index)")
            NotificationCenter.default.post(name: notificationName, object: self,
                                            userInfo: ["index" : index])
            currentIndex = index

        }
    }

}
