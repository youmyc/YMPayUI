//
//  Common.swift
//  YMPayUI
//
//  Created by youmy on 2018/11/19.
//  Copyright © 2018 youmyyoumy. All rights reserved.
//

import Foundation
import UIKit

let bundle = Bundle(path: Bundle.main.path(forResource: "YMPayUIBundle.bundle", ofType: nil) ?? "")

/// 屏幕尺寸
let ym_screen_bounds = UIScreen.main.bounds

/// 屏幕大小
let ym_screen_size = UIScreen.main.bounds.size

/// 屏幕宽度
let ym_screen_width = UIScreen.main.bounds.width

/// 屏幕高度
let ym_screen_height = UIScreen.main.bounds.height

/// 分隔线颜色 0xf0f0f0
let ym_seprator_color = UIColor.init(valueRGB: 0xf0f0f0, alpha: 1)

/// 背景色 0xf5f6f7
let ym_bg_color = UIColor.init(valueRGB: 0xf5f6f7, alpha: 1)

// 字体
/// 苹方-Regular
let PingFangSC_Regular = "PingFangSC-Regular"

/// 苹方-Medium
let PingFangSC_Medium = "PingFangSC-Medium"

/// 支付方式
public enum PayStyle:Int {
    /// 花呗分期
    case Huabei
    /// 苹果支付
    case ApplePay
    /// 支付宝
    case AliPay
    /// 微信
    case Wechat
    /// 连连
    case LLPay
    
    case None
}


func resoucearrayFromFile(fileName: String) -> [[String:Any]] {
    
    let jsonPath = bundle?.path(forResource: fileName, ofType: nil)
    
//    let jsonPath = Bundle.main.path(forResource: fileName, ofType: nil)
    
    guard let path = jsonPath else {
        return [[String: Any]]()
    }
    
    let data = try? Data(contentsOf: URL(fileURLWithPath: path))
    
    if data != nil {
        let arr = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! Array<Dictionary<String, Any>>
        return arr ?? [[String: Any]]()
    }
    return [[String: Any]]()
}


///获取当前控制器
func currentVc() ->UIViewController{
    
    var vc = UIApplication.shared.keyWindow?.rootViewController
    
    if (vc?.isKind(of: UITabBarController.self))! {
        vc = (vc as! UITabBarController).selectedViewController
    }else if (vc?.isKind(of: UINavigationController.self))!{
        vc = (vc as! UINavigationController).visibleViewController
    }else if ((vc?.presentedViewController) != nil){
        vc =  vc?.presentedViewController
    }
    
    return vc!
    
}
