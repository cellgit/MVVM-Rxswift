//
//  HotKeyListModel.swift
//  MVVMRxswift
//
//  Created by 刘宏立 on 2020/7/29.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import Foundation
import ObjectMapper


struct HotKeyListModel: Mappable {
    /// id
    var id: Int?
    /// 快捷键
    var hotkey: Int?
    /// 功能描述
    var function: Int?
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        hotkey <- map["hotkey"]
        function <- map["function"]
    }
    
    init?(map: Map) {}
    init() {}
}

