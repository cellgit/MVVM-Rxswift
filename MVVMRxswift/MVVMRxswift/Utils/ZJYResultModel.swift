//
//  ZJYResultModel.swift
//  SWArchitecture
//
//  Created by 刘宏立 on 2020/7/29.
//  Copyright © 2020 liuhongli. All rights reserved.
//

import Foundation
import ObjectMapper

//MARK: 上传接口 返回数据解析
struct ZJYResultModel: Mappable {
    
    var errcode:Int?
    var errmsg = ""
    var version:Int?
    var state:Int?//0=更新成功，-1=更新失败"
    var res = ZJYResult_resModel()
    
    mutating func mapping(map: Map) {
        
        errcode <- map["errcode"]
        errmsg <- map["errmsg"]
        version <- map["version"]
        state <- map["state"]
        res <- map["res"]
    }
    
    init?(map: Map) {
        
    }
    init() {
        
    }
}

struct ZJYResult_resModel: Mappable {
    
    var state:Int?
    
    mutating func mapping(map: Map) {
        
        state <- map["state"]
    }
    
    init?(map: Map) {}
    init() {}
}

