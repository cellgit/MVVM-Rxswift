//
//  Moya+Extension.swift
//  Life on Road
//
//  Created by 刘宏立 on 2020/7/28.
//  Copyright © 2020 S.S.S.S.S.S.S.S. All rights reserved.
//

import Foundation
import UIKit
import Moya
import ObjectMapper

//MARK:对moya请求参数 根据服务器要求进行 封装
public extension TargetType {
    
    func requestParamter(_ paramter:[String:Any]) -> Task {
        return Task.requestParameters(parameters: addDataParamter(paramter), encoding: URLEncoding.default)
    }
    //对请求参数封装
    fileprivate func addDataParamter(_ paramter:[String:Any]?) -> [String:Any]{
        
        //MARK:如果以后更改就按照注释更改
//        var newParamter:[String:Any] = [:]
//        newParamter["ver"] = ver
//        newParamter["vst"] = vst
//
//        guard let data = try? JSONSerialization.data(withJSONObject: paramter as Any, options: []) else {
//            return newParamter
//        }
//
//        guard let JSONString = String.init(data: data, encoding: String.Encoding.utf8) else {
//            return newParamter
//        }
//
//        newParamter["data"] = JSONString
//        //打印请求
//        //        print("paramter===",newParamter.debugDescription)
        return paramter ?? [:]
    }
    
    
}

