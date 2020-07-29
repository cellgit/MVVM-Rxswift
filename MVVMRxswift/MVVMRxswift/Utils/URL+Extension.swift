//
//  URL+Extension.swift
//  MVVMRxswift
//
//  Created by 刘宏立 on 2020/7/29.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import Foundation

extension URL{
    static func initUrl(string:String) -> URL
    {
        let urlwithPercentEscapes = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL.init(string: urlwithPercentEscapes!)
        return url!
    }
}
