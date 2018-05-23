//
//  AutoLoginViewController.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/23.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class AutoLoginViewController: BaseViewController {
    var timer:Timer!
    var timeDuration = 4
    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "重置密码"
         timeLabel.text = "将在\(timeDuration)S后自动跳转登录页"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeFun), userInfo: nil, repeats: true)
    }
    @objc func timeFun(){
        if timeDuration > 0{
            timeDuration = timeDuration - 1
            timeLabel.text = "将在\(timeDuration)S后自动跳转登录页"
            
        }else{
            timer.invalidate()
            let window = UIApplication.shared.keyWindow!
            let tabbarVC = BaseTabBarViewController()
            window.rootViewController = tabbarVC
            window.makeKeyAndVisible()
            window.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
        }
    }

  
}
