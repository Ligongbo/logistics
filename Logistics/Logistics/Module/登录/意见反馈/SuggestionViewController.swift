//
//  SuggestionViewController.swift
//  Logistics
//
//  Created by 王岩 on 2018/5/24.
//  Copyright © 2018年 王岩. All rights reserved.
//

import UIKit

class SuggestionViewController: BaseViewController {
    @IBOutlet weak var selectImageBtn: UIButton!
    @IBOutlet var wordsTextView: UIPlaceholderTextView!
    @IBOutlet weak var wordsCountLabel: UILabel!
    var imagePicker:TZImagePickerController!
    var selectAsset:PHAsset?
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
    }

  
    @IBAction func selectImageClick(_ sender: UIButton) {
        initImagePick()
        imagePicker.maxImagesCount = 1
        imagePicker.urlCount = 0
        
            if selectAsset != nil{
                imagePicker?.selectedAssets = [selectAsset]
            }
            imagePicker?.didFinishPickingPhotosHandle = {
                (photos,assets,isSelectOriginalPhoto) in
                if photos != nil && (photos?.count)! > 0{
                    sender.setBackgroundImage(photos![0], for: .normal)
                }
                
            }
        UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker!, animated: true, completion: nil)
        
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
    func initImagePick(){
        imagePicker = TZImagePickerController.init(maxImagesCount: 1, delegate: self,urlCount:0)
        // 在内部是否显示拍照按钮
        imagePicker?.allowTakePicture = true
        imagePicker?.sortAscendingByModificationDate = false
    }
}
