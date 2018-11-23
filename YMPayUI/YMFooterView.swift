//
//  YMFooterView.swift
//  YMPayUI
//
//  Created by youmy on 2018/11/23.
//  Copyright © 2018 youmy. All rights reserved.
//

import UIKit

protocol YMFooterViewDelegate {
    func protocolDidBtn(view:YMFooterView)
    func agreeDidBtn(view:YMFooterView, btn:UIButton)
}

class YMFooterView: UIView {
    
    var delegate:YMFooterViewDelegate?
    
    lazy var agreeIV:UIImageView = {
        let imageV = UIImageView(frame: CGRect(x: 20, y: 0, width: 17, height: 17))
        imageV.centerY = centerY
        imageV.image = UIImage(named: "单选框-选中", in: bundle, compatibleWith: nil)
        return imageV
    }()
    
    lazy var agreeBtn:UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: agreeIV.frame.maxX + 10, height: height))
        btn.addTarget(self, action: #selector(agreeBtnAction(sender:)), for: .touchDown)
        btn.isSelected = true
        return btn
    }()
    
    lazy var protocolBtn:UIButton = {
        let x:CGFloat = agreeIV.frame.maxX + 10
        let btn = UIButton(frame: CGRect(x: x, y: 0, width: width - 2 * x, height: height))
        btn.titleLabel?.font = UIFont(name: PingFangSC_Regular, size: 13)
        btn.setTitleColor(UIColor(valueRGB: 0x242424, alpha: 1), for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.addTarget(self, action: #selector(protocolBtnAction(sender:)), for: .touchDown)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ym_bg_color
        
        addSubview(agreeIV)
        addSubview(protocolBtn)
        addSubview(agreeBtn)
        
        let str = "同意并已阅读《用户租赁及服务协议》"
        let subString = "《用户租赁及服务协议》"
        let range = (str as NSString).range(of: subString)
        let attrStr = NSMutableAttributedString(string: str)
        attrStr.addAttribute(.foregroundColor, value: UIColor(valueRGB: 0x0FD9D7, alpha: 1), range: range)
        protocolBtn.setAttributedTitle(attrStr, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension YMFooterView {
    @objc func agreeBtnAction(sender:UIButton){
        sender.isSelected = !sender.isSelected
        agreeIV.image = UIImage(named: sender.isSelected ? "单选框-选中" : "单选框-默认", in: bundle, compatibleWith: nil)
        if delegate != nil {
            delegate?.agreeDidBtn(view: self, btn: sender)
        }
    }
    
    @objc func protocolBtnAction(sender:UIButton){
        
        if (delegate != nil) {
            delegate?.protocolDidBtn(view: self)
        }
    }
}
