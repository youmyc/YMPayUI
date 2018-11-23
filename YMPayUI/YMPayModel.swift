//
//    YMPayModel.swift
//
//    Create by youmy on 13/7/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct YMPayModel{
    /// 图标
    var icon : String!
    /// 名称
    var name : String!
    /// 类型
    var type : String!
    /// 描述
    var des : String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        icon = dictionary["icon"] as? String
        name = dictionary["name"] as? String
        type = dictionary["type"] as? String
        des = dictionary["des"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if icon != nil{
            dictionary["icon"] = icon
        }
        if name != nil{
            dictionary["name"] = name
        }
        if type != nil{
            dictionary["type"] = type
        }
        if des != nil{
            dictionary["des"] = des
        }
        return dictionary
    }
    
}
