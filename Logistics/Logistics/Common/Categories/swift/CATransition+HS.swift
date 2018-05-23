//
//  CATransition+Animation.swift
//  testCode
//
//  Created by 李琪 on 16/7/19.
//  Copyright © 2016年 李琪. All rights reserved.
//


/**
 UIApplication.sharedApplication().keyWindow?.rootViewController = ViewController2(nibName: "ViewController2", bundle: nil)
 UIApplication.sharedApplication().keyWindow?.layer.addAnimation(CATransition.animationWithType(KYNaviAnimationType(rawValue: indexPath.row + 1)!, direction: .Top), forKey: nil)
 */



import UIKit
enum KYNaviAnimationType:Int{
    case fade        = 1    //淡化
    case push        = 2    //推挤
    case reveal      = 3    //揭开
    case moveIn      = 4    //覆盖
    case cube        = 5    //立方体
    case suck        = 6    //吸收
    case spin        = 7    //旋转
    case ripple      = 8    //波纹
    case pageCurl    = 9    //翻页
    case pageUnCurl  = 10   //反翻页
    case cameraOpen  = 11   //镜头开
    case cameraClose = 12   //镜头关
}


enum KYNaviAnimationDirection{
    case left
    case right
    case top
    case bottom
}
extension CATransition {
    class func animationWithType(_ animationType:KYNaviAnimationType) -> CATransition{
        return CATransition.animationWithType(animationType, direction: .top)
    }
    
    class func animationWithType(_ animationType:KYNaviAnimationType, direction:KYNaviAnimationDirection) -> CATransition{
        
        let animation = CATransition()
        animation.duration = 0.5
        
        switch (animationType) {
        case .fade:
            animation.type = kCATransitionFade; //淡化.
        case .push:
            animation.type = kCATransitionPush; //推挤.
        case .reveal:
            animation.type = kCATransitionReveal; //揭开.
        case .moveIn:
            animation.type = kCATransitionMoveIn;//覆盖.
        case .cube:
            animation.type = "cube";   //立方体.
        case .suck:
            animation.type = "suckEffect"; //吸收.
        case .spin:
            animation.type = "oglFlip";    //旋转.
        case .ripple:
            animation.type = "rippleEffect";   //波纹.
        case .pageCurl:
            animation.type = "pageCurl";   //翻页.
        case .pageUnCurl:
            animation.type = "pageUnCurl"; //反翻页.
        case .cameraOpen:
            animation.type = "cameraIrisHollowOpen";   //镜头开.
        case .cameraClose:
            animation.type = "cameraIrisHollowClose";  //镜头关.
        }
        
        switch (direction) {
        case .left:
            animation.subtype = kCATransitionFromLeft
        case .right:
            animation.subtype = kCATransitionFromRight
        case .top:
            animation.subtype = kCATransitionFromTop
        case .bottom:
            animation.subtype = kCATransitionFromBottom
        }
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        
        
        return animation;
        
    }

}
