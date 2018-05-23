//
//  BaseTabBarViewController.swift
//  MiddleSchool2_teacher
//
//  Created by 李琪 on 2017/5/4.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    func setupTabBar(){
        //应用
        let firstVC = ApplyViewController(nibName: "ApplyViewController", bundle: nil)
        addChildViewController(firstVC, title: "应用", image: "gailanh", selectedImage: "gailan")
        
        //课表
        let secondVC = ScheduleViewController(nibName: "ScheduleViewController", bundle: nil)
        addChildViewController(secondVC, title: "课表", image: "jiankongh", selectedImage: "jiankong")
        
        //我的
        let thirdVC = MineViewController(nibName: "MineViewController", bundle: nil)
        addChildViewController(thirdVC, title: "我的", image: "baojingh", selectedImage: "baojing")
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor(hexString:"9A9A9A"), NSAttributedStringKey.font:UIFont.systemFont(ofSize: 11)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor(hexString:"3075b4"), NSAttributedStringKey.font:UIFont.systemFont(ofSize: 11)], for: .selected)

    }
    
    func addChildViewController(_ childController:UIViewController, title:String, image:String, selectedImage:String){
        if title == "我的"{
            childController.tabBarItem.title = title
        }else{
            childController.title = title
        }
        

        
        childController.tabBarItem.image = UIImage.loadImage(image).withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage.loadImage(selectedImage).withRenderingMode(.alwaysOriginal)
 
        
        childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor(hexString:"9A9A9A")], for: .normal)
        childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor(hexString:"3075b4")], for: .selected)
        let mainNav = BaseNavigationViewController(rootViewController: childController)
        addChildViewController(mainNav)
    }



}
