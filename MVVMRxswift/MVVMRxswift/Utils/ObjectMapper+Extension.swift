//
//  ObjectMapper+Extension.swift
//  Life on Road
//
//  Created by 刘宏立 on 2020/7/28.
//  Copyright © 2020 S.S.S.S.S.S.S.S. All rights reserved.
//

import Foundation
import UIKit
import Moya
import RxSwift
import ObjectMapper
//import Result

//MARK: 继续返回数据封装

enum NetWorkServerError: String {
    case parseJSONError //解析错误
    case otherError //其他错误
}


extension NetWorkServerError: Swift.Error {}


extension Observable {
    // MARK:- 解析字典
    public func mapModel<T:Mappable>(type: T.Type, key: String? = nil) -> Observable<T> {
        
        return self.map { response in
            
            //解析数据
            guard let dict = response as? [String: Any] else {
                throw NetWorkServerError.parseJSONError
            }
            
            //根据固定的key 解析 数据
            if let k = key {
                guard let dictionary = dict[k] as? [String: Any] else {
                    throw NetWorkServerError.parseJSONError
                }
                return Mapper<T>().map(JSON: dictionary)!
            }
            //直接解析数据
            return Mapper<T>().map(JSON: dict)!
        }
    }
    
    // MARK:- 解析数组: 有key值
    public func mapArray<T: Mappable>(type: T.Type, key: String? = nil) -> Observable<[T]> {
        
        return self.map { response in
            
            //解析 数据
            guard let dict = response as? [String: Any] else {
                throw NetWorkServerError.parseJSONError
            }
            
            //根据固定的key 解析 数据
            if key != nil {
                guard let dictionary = dict[key!] as? [[String: Any]] else {
                    throw NetWorkServerError.parseJSONError
                }
                return Mapper<T>().mapArray(JSONArray: dictionary)
            } else {
                
                guard let array = response as? [Any] else {
                    throw NetWorkServerError.parseJSONError
                }
                guard let dicts = array as? [[String: Any]] else {
                    throw NetWorkServerError.parseJSONError
                }
                //直接解析数据
                return Mapper<T>().mapArray(JSONArray: dicts)
            }
        }
    }
    
    // MARK:- 解析数组: 无key值
    public func mapArrayWithoutKey<T: Mappable>(type: T.Type) -> Observable<[T]> {
        
        return self.map { response in
            guard let array = response as? [Any] else {
                throw NetWorkServerError.parseJSONError
            }
            guard let dicts = array as? [[String: Any]] else {
                throw NetWorkServerError.parseJSONError
            }
            //直接解析数据
            return Mapper<T>().mapArray(JSONArray: dicts)
        }
    }
}
