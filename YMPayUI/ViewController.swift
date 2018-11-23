//
//  ViewController.swift
//  YMPayUI
//
//  Created by youmy on 2018/11/20.
//  Copyright © 2018 youmy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var payView:YMPayView? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        payView = YMPayView.init(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 50))
        payView?.isApplePay = true
        payView?.payStyle = .Wechat
//        payView?.huabeiStaging("(免手续费：¥462.08／期x12期)")
        view.addSubview(payView!)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let payStyle = payView?.payStyle else {
            return
        }
        
        switch payStyle {
        case .Huabei:
            print("Huabei")
        case .ApplePay:
            print("ApplePay")
        case .AliPay:
            print("AliPay")
        case .Wechat:
            print("Wechat")
        case .LLPay:
            print("LLPay")
        case .None:
            print("请选择支付方式")
        }
    }
}

