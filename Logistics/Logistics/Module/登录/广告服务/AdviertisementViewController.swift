//
//  AdviertisementViewController.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/24.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class AdviertisementViewController: BaseViewController {
    @IBOutlet var wordsTextView: UIPlaceholderTextView!
    @IBOutlet weak var wordsCountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexString: "F3F3F3")
        title = "广告服务"
        wordsTextView.placeholder = "请输入您的留言"
        wordsTextView.delegate = self
    }
    @IBAction func finishClick(_ sender: Any) {
    }
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBAction func phoneClick(_ sender: Any) {
        let phoneNum = "tel:400-686-5997"
        let callWebview = UIWebView()
        callWebview.loadRequest(URLRequest.init(url: URL.init(string: phoneNum)!))
        self.view.addSubview(callWebview)
       
     
    }
    
 
    
}
extension AdviertisementViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        if (textView.markedTextRange == nil && textView.text.characters.count >= 600) {
            if wordsTextView.text != nil{
                wordsTextView.text = (textView.text! as NSString).substring(to: 600)
                
            }
            
            
        }
        if wordsTextView.text == nil{
            wordsCountLabel.text = "0/600"
        }else{
             wordsCountLabel.text = String(wordsTextView.text.characters.count) + "/600"
        }
       
    }
}
