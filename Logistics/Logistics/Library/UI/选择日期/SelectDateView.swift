//
//  SelectDateView.swift
//  选择日期actionsheet
//
//  Created by 王岩 on 2017/6/5.
//  Copyright © 2017年 王岩. All rights reserved.
//

import UIKit

protocol SelectDateDelegate {
     func selectDate(dateString:String)
}

class SelectDateView: UIView {
    var pro:SelectDateDelegate?
    var delegate:UIViewController?
    var alert:UIAlertController?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    init(delegate:UIViewController) {
        super.init(frame: CGRect.zero)
        
        self.delegate = delegate
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        let locale = Locale.init(identifier: "zh_CN")
        datePicker.locale = locale
        alert = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        alert?.view.addSubview(datePicker)
        let ok = UIAlertAction(title: "确定", style: .default) { (UIAlertAction) in
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "YYYY-MM-dd"
            let dateString = dateFormat.string(from: datePicker.date)
            print(dateString)
            self.pro?.selectDate(dateString: dateString)
            
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (UIAlertAction) in
            print("cancel")
        }
        alert?.addAction(ok)
        alert?.addAction(cancel)
        
    }
    func show(){
        self.delegate?.present(alert!, animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
