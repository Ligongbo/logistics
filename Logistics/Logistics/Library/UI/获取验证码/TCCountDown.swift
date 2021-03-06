//
//  TCCountDown.swift
//  MiddleSchool2_teacher
//
//  Created by 王岩 on 2017/6/8.
//  Copyright © 2017年 李琪. All rights reserved.
//

import Foundation

class TCCountDown {
    var getCodeButton:UIButton!
    var countdownTimer: Timer?
    private var remainingSeconds: Int = 0 {
        willSet {
            getCodeButton.backgroundColor = UIColor(hexString:"A9B2BD")
            getCodeButton.setTitle("(\(newValue))后重新获取", for: .normal)
            if newValue <= 0 {
                getCodeButton.backgroundColor = UIColor(hexString: "00B7FB")
                getCodeButton.setTitle("获取验证码", for: .normal)
                isCounting = false
            }
        }
    }
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                remainingSeconds = 60
                getCodeButton.setTitleColor(UIColor.white, for: .normal)
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                getCodeButton.setTitleColor(UIColor.white, for: .normal)
            }
            getCodeButton.isEnabled = !newValue
        }
    }
    @objc private func updateTime() {
        remainingSeconds -= 1
    }
}
