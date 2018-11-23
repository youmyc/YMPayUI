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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let payView = YMPayView.init(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 50))
        
        view.addSubview(payView)
        
    }


}

