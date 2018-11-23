//
//  YMPayCell.swift
//  YMPayUI
//
//  Created by youmy on 2018/11/19.
//  Copyright © 2018 youmyyoumy. All rights reserved.
//

import UIKit
import PassKit

fileprivate let randomColor = UIColor.white


class YMPayCell: UITableViewCell {
    
    /// 支付图标
    lazy var iconIV: UIImageView = {
        let imageV = UIImageView(frame: CGRect(x: 20, y: 0, width: 22, height: 22))
        imageV.backgroundColor = randomColor
        imageV.centerY = centerY
        return imageV
    }()
    
    /// 支付名称
    var titleLbl: UILabel!
    
    /// 是否选中
    lazy var selIV: UIImageView = {
        let imageV = UIImageView(frame: CGRect(x: ym_screen_width - 17 - 20, y: 0, width: 17, height: 17))
        imageV.backgroundColor = randomColor
        imageV.centerY = iconIV.centerY
        imageV.image = UIImage(named: "单选框-默认", in: bundle, compatibleWith: nil)
        return imageV
    }()
    
    /// logo
    var logoIV: UIImageView!

    var noteLb: UILabel!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(iconIV)
        contentView.addSubview(selIV)
        
        titleLbl = UILabel()
        titleLbl.backgroundColor = randomColor
        titleLbl.font = UIFont.init(name: PingFangSC_Regular, size: 15)
        titleLbl.textColor = UIColor.init(valueRGB: 0x242424, alpha: 1)
        
        noteLb = UILabel()
        noteLb.backgroundColor = randomColor
        noteLb.textAlignment = .right
        noteLb.font = UIFont.init(name: PingFangSC_Regular, size: 11)
        noteLb.textColor = UIColor.init(valueRGB: 0xb4b4b4, alpha: 1)
        
        logoIV = UIImageView()
        logoIV.image = UIImage(named: "银联云闪付icon", in: bundle, compatibleWith: nil)
        logoIV.isHidden = true
        
        contentView.addSubview(titleLbl)
        contentView.addSubview(noteLb)
        contentView.addSubview(logoIV)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLbl.frame = CGRect(origin: CGPoint(x: iconIV.frame.maxX + 10, y: 0), size: titleLbl.bounds.size)
        titleLbl.centerY = iconIV.centerY
        
        noteLb.frame = CGRect(origin: CGPoint(x: titleLbl.frame.maxX + 10, y: 0), size: noteLb.bounds.size)
        noteLb.width = selIV.frame.minX - titleLbl.frame.maxX - 10 - 10
        noteLb.centerY = iconIV.centerY
        
        logoIV.frame = CGRect(x: titleLbl.frame.maxX + 29, y: 0, width: 64, height: 18)
        logoIV.centerY = iconIV.centerY
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension YMPayCell {
    func config(_ model:YMPayModel?){
        logoIV.isHidden = true
        
        titleLbl.text = model?.name
        iconIV.image = UIImage(named: model?.icon ?? "", in: bundle, compatibleWith: nil)
        
        if model?.type ?? "" == "apple" {
            logoIV.isHidden = false
            let payButton = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .whiteOutline)
            payButton.isEnabled = false
            payButton.frame = CGRect(x: 20, y: 0, width: 29, height: 18)
            payButton.centerY = iconIV.centerY
            contentView.addSubview(payButton)
        }
        
        noteLb.text = model?.des
        
        titleLbl.sizeToFit()
        noteLb.sizeToFit()
    }
}
