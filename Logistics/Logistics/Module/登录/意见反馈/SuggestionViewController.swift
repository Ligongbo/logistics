//
//  SuggestionViewController.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/24.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class SuggestionViewController: BaseViewController {
    
@IBOutlet var imageContainer: UIView!
    
    @IBOutlet var wordsTextView: UIPlaceholderTextView!
    @IBOutlet weak var wordsCountLabel: UILabel!
    var imagePicker:TZImagePickerController!
    var images:Array<PhotoBrowserShowModel> = [PhotoBrowserShowModel]()
    var selectImageView:CommonSelectImageView!
    @IBAction func phoneClick(_ sender: Any) {
        let phoneNum = "tel:400-686-5997"
        let callWebview = UIWebView()
        callWebview.loadRequest(URLRequest.init(url: URL.init(string: phoneNum)!))
        self.view.addSubview(callWebview)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexString: "F3F3F3")
        title = "意见反馈"
        wordsTextView.placeholder = "请输入您的留言"
        wordsTextView.delegate = self
        initUI()
    }

  
   
    
}
extension SuggestionViewController{
    func initUI(){
        selectImageView = UIView.loadViewWithName("CommonSelectImageView") as! CommonSelectImageView
        selectImageView.drawInView(imageContainer)
        selectImageView.kwidth = ScreenWidth - 124
        selectImageView.total = 3
        selectImageView.canEdit = true
        selectImageView.update(photos: self.images) { (images, height) in
            self.images = images
            
        }

    }
}
extension SuggestionViewController:UITextViewDelegate{
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

extension SuggestionViewController:TZImagePickerControllerDelegate{
  
}
