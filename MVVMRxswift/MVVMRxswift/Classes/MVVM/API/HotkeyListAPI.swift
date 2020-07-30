//
//  HotkeyListAPI.swift
//  MVVMRxswift
//
//  Created by 刘宏立 on 2020/7/29.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import Foundation
import UIKit
import Moya
import RxSwift

struct CType {
    static let json = "application/json"
    static let form = "application/x-www-form-urlencoded"
}

struct HeaderKey {
    static let contentType = "Content-Type"
    static let token = "KY-TOKEN"
    static let visitorToken = "KY-VISITOR-TOKEN"
    static let time = "timestamp"
    static let sign = "sign"
    static let version = "KY-VERSION"
    static let appType = "KY-APPTYPE"
}

extension Bundle {
    static func appVersion() -> String {
        var versionStr = ""
        if let info = Bundle.main.infoDictionary {
            let appVersion = info["CFBundleShortVersionString"] as? String ?? "Unknown"
            let appBuild = info[kCFBundleVersionKey as String] as? String ?? "Unknown"
            versionStr = (appVersion == "Unknown") ? appVersion : appBuild
        }
        return versionStr
    }
}

//MARK:网络请求时 使用这个对象
let HotKeyListAPIProvider: MoyaProvider = MoyaProvider<HotKeyListAPI>(stubClosure: MoyaProvider.neverStub, plugins: [NetWorkResponsePlugin()])

//MARK:枚举请求api
enum HotKeyListAPI {
    case list(param:[String:Any])
}

//MARK:对枚举进行拓展继承Moya的 TargetType 协议
extension HotKeyListAPI: TargetType {
    /// The target's base `URL`.服务器base地址
    var baseURL: URL {
        //MARK: 接口写这里，咱们接口带有？号要统一转码，要是分开转码在拼接会出现？替换为其他的字符
        var path = ""
        switch self {
            
        case .list(_):
            path = "hotkeys"
            let urlStr: String = APIManager.baseUrl + path
            return URL.initUrl(string: urlStr)
        }
    }
    
    var headers: [String : String]? {
        // 设置请求头参数(公共参数)
        
        //        if App.isLogin {
        //            return ["KY-TOKEN": "token", "KY-APPTYPE": "1", "KY-VERSION": "1.0.0", "KY-CATEGORY": "2"]
        //        }else {
        //            let v_token =  "IDFVTool.getIDFVStr()"
        //            return ["KY-TOKEN": "token" ,"KY-VISITOR-TOKEN": v_token, "KY-APPTYPE": "1" , "KY-VERSION": "1.0.0","KY-CATEGORY": "2"]
        //        }
        
        return ["Content-Type":"application/json"]
    }
    
    
    /// The path to be appended to `baseURL` to form the full `URL`.枚举请求接口
    var path: String {
//        let path = "hotkeys"
        return ""//APIManager.baseUrl + path
    }
    
    /// The HTTP method used in the request.枚举请求不同接口返回不同的请求方式
    var method: Moya.Method {
        switch self {
        case .list(_):
            return .post
        }
    }
    
    /// Provides stub data for use in testing.样本数据
    var sampleData: Data {
        switch self {
        default:
            return "{\"body\":{\"list\":[{},{},{}]}}".data(using: .utf8)!
        }
    }
    
    /// The type of HTTP task to be performed.枚举请求接口，并对相应接口传递参数
    var task: Task {
        var paramaters:[String:Any]?
        switch self {
        case .list(let param):
            paramaters = param
            return paramaters == nil ? .requestPlain : requestParamter(paramaters!)
        }
    }
    
    var validate: Bool {
        return false
    }
    
}

