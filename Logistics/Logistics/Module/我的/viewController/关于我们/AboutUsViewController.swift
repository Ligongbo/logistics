//
//  AboutUsViewController.swift
//  SeniorHighSchoolProject
//
//  Created by 王岩 on 2017/10/17.
//  Copyright © 2017年 MR. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseViewController {

    @IBAction func btnClick(_ sender: UIButton) {
        performToGuideViewController()
    }
    @IBOutlet weak var versionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "关于我们"
        // Do any additional setup after loading the view.
        let infoDictionary = Bundle.main.infoDictionary
        versionLabel.text = "版本号:\(infoDictionary!["CFBundleShortVersionString"] as! String)"
    }
    //跳转至引导页
    func performToGuideViewController(){
        let window = UIApplication.shared.keyWindow
        let picArr = [UIImage.loadImage("guidePage1"),UIImage.loadImage("guidePage2"),UIImage.loadImage("guidePage3")]
        let titleArr = ["立即体验"]
        
        let guideVC = MSGuidePageViewController.sharedGuideVC()
        guideVC.guidePage(withPicArray: picArr, andTitleArray: titleArr)
        
        window?.rootViewController = guideVC
        window?.makeKeyAndVisible()
        window?.layer.add(CATransition.animationWithType(.push, direction: .top), forKey: nil)
    }
   

}
