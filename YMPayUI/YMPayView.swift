//
//  YMPayView.swift
//  YMPayUI
//
//  Created by youmy on 2018/11/19.
//  Copyright © 2018 youmyyoumy. All rights reserved.
//

import UIKit

fileprivate let kCellId = "kCellId"

public protocol YMPayViewDelegate {
    func protocolDidBtn(view:YMPayView)
}

public class YMPayView: UIView {
    
    public var delegate:YMPayViewDelegate?
    
    public var isAgree:Bool = true
    
    fileprivate var footerV:YMFooterView?
    
    fileprivate var tableView:UITableView?
    
    fileprivate var selRow:Int? = 0
    
    fileprivate var defaultPay = "alipay"
    
    public var payStyle:PayStyle = .AliPay {
        didSet{
            switch payStyle {
            case .Huabei:
                defaultPay = "huabei"
            case .ApplePay:
                defaultPay = "apple"
            case .AliPay:
                defaultPay = "alipay"
            case .Wechat:
                defaultPay = "wechat"
            case .LLPay:
                defaultPay = "bank"
            default:
                payStyle = .None
            }
            
            setDefaultPay()
        }
    }
    
    fileprivate var source = [YMPayModel]()
    
    fileprivate var isHuabei = false
    
    /// 是否支付苹果支付
    public var isApplePay:Bool = false {
        didSet{
            setData()
        }
    }
    
    fileprivate lazy var headerV:UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: ym_screen_width, height: 27))
        v.backgroundColor = ym_bg_color
        let label = UILabel(frame: CGRect(x: 20, y: 8, width: ym_screen_width - 40, height: 11))
        label.font = UIFont.init(name: PingFangSC_Regular, size: 11)
        label.textColor = UIColor.init(valueRGB: 0x0fd9d7, alpha: 1)
        label.text = "支付方式"
        v.addSubview(label)
        return v
    }()
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        footerV = YMFooterView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 57))
        footerV?.delegate = self
        
        setData()
        
        tableView = UITableView(frame: bounds)
        tableView?.isScrollEnabled = false
        tableView?.tableHeaderView = headerV
        tableView?.width = ym_screen_width
        tableView?.tableFooterView = footerV
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.separatorColor = UIColor.init(valueRGB: 0xf0f0f0, alpha: 1)
        tableView?.register(YMPayCell.classForCoder(), forCellReuseIdentifier: kCellId)
        addSubview(tableView!)
    }
    
    func setData(_ des:String = ""){
        let arr = resoucearrayFromFile(fileName: "pay.json")
        
        source.removeAll()
        
        for dic in arr {
            var model = YMPayModel(fromDictionary: dic)
            
            if model.type ?? "" == "apple" {
                if isApplePay {
                    payStyle = .ApplePay
                    source.append(model)
                }
            }else if model.type ?? "" == "huabei"{
                if isHuabei {
                    model.des = des
                    source.append(model)
                }
            }else{
                source.append(model)
            }
        }
        
        setDefaultPay()
    }
    
    func setDefaultPay(){
        var i = 0
        for model in source {
            if model.type ?? "" == defaultPay {
                selRow = i
            }
            i = i+1
        }
        
        let count = source.count
        self.frame = CGRect(x: 0, y: self.frame.origin.y, width: ym_screen_width, height: 26 + 50 * CGFloat(count) + 57)
        tableView?.frame = bounds
    }
    
    
    /// 花呗分期
    ///
    /// - Parameter des: 描述
    public func huabeiStaging(_ des:String){
        isHuabei = true
        setData(des)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YMPayView: UITableViewDataSource, UITableViewDelegate{
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellId, for: indexPath) as! YMPayCell
        let model = source[indexPath.row]
        cell.config(model)
        
        if indexPath.row == selRow {
            cell.selIV.image = UIImage(named: "单选框-选中", in: bundle, compatibleWith: nil)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selRow = indexPath.row
        
        let arr = tableView.visibleCells
        let cell = tableView.cellForRow(at: indexPath) as! YMPayCell
        for obj in arr {
            if obj is YMPayCell {
                let cell = obj as! YMPayCell
                cell.selIV.image = UIImage(named: "单选框-默认", in: bundle, compatibleWith: nil)
            }
        }
        
        let model = source[indexPath.row]
        
        switch model.type ?? "" {
        case "huabei":
            payStyle = .Huabei
        case "alipay":
            payStyle = .AliPay
        case "wechat":
            payStyle = .Wechat
        case "apple":
            payStyle = .ApplePay
        case "bank":
            payStyle = .LLPay
        default:
            payStyle = .None
        }
        
        cell.selIV.image = UIImage(named: "单选框-选中", in: bundle, compatibleWith: nil)
    }
}

extension YMPayView: YMFooterViewDelegate {
    func agreeDidBtn(view: YMFooterView, btn: UIButton) {
        isAgree = btn.isSelected
    }
    
    func protocolDidBtn(view: YMFooterView) {
        if delegate != nil {
            delegate?.protocolDidBtn(view: self)
        }
    }
    
}
