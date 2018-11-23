//
//  ViewController.swift
//  Demo
//
//  Created by youmy on 2018/11/20.
//  Copyright © 2018 youmy. All rights reserved.
//

import UIKit
import PayUI

class ViewController: UIViewController {

    var payView:YMPayView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        payView = YMPayView.init(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 50))
        payView?.delegate = self
        view.addSubview(payView!)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let payStyle = payView?.payStyle else {
            return
        }
        
        print("-->\(payView?.isAgree ?? true)")
        
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

extension ViewController: YMPayViewDelegate {
    func protocolDidClick(view: YMPayView) {
        print("---> protocol")
    }
    
}
