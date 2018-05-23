//
//  WebViewController.swift
//  MiddleSchool2_teacher
//
//  Created by 王岩 on 2017/5/15.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

class CommonWebViewController: BaseViewController,UIWebViewDelegate {
    var webView:UIWebView!

    var urlContent = ""
    var titleContent = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        URLCache.shared.removeAllCachedResponses()
        webView = UIWebView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64))
        
        title = titleContent
        
        //        urlContent = "http://192.168.13.80/cas/login?service=http://192.168.13.80/company/shiro-cas"
        let url = URL(string: urlContent)
        if url != nil {
            let request = URLRequest(url: url!)
            webView.loadRequest(request)
        }else{
            print("url为空")
        }
        webView.delegate = self
        webView.scalesPageToFit = true
        self.view.addSubview(webView)
       
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.loadImage("arrow_back"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.back))
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print(webView.stringByEvaluatingJavaScript(from: "document.location.href"))
        
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
}

