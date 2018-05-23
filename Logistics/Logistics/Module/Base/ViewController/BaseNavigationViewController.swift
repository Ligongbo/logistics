//
//  BaseNavigationViewController.swift
//  MiddleSchool2_teacher
//
//  Created by 李琪 on 2017/5/4.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置导航条样式
        //TODO:根据实际样式编写
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white,
                                                            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)]
        UINavigationBar.appearance().barTintColor = UIColor(hexString: "00BBF7")
//        UINavigationBar.appearance().barTintColor = UIColor.init(patternImage: UIImage.init(named: "logo")!)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = false
    }
    
    //    /**
    //     * 重写这个方法的目的是拦截所有push进来的控制器
    //     * @param viewController 即将push进来的控制器
    //     * @param animated 是否有动画效果
    //     */
    //    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    //        if viewControllers.count > 0{
    //            viewController.hidesBottomBarWhenPushed = true
    //            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.loadImage("arrow_back"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.back))
    //        }
    //        super.pushViewController(viewController, animated: animated)
    //    }
    //
    //
    //
    //    func back(){
    //        popViewController(animated: true)
    //    }
    
}
