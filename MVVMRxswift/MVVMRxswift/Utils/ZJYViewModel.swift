//
//  ZJYViewModel.swift
//  MVVMRxswift
//
//  Created by 刘宏立 on 2020/7/30.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import Moya

struct ZJYViewModel {
    
    /// 返回结果为list的请求
    /// - Parameters:
    ///   - param: 请求所需参数 示例 HotKeyListAPI.list(param: ["":""])
    ///   - type: 模型类型
    ///   - provider: provider
    ///   - success: 成功回调
    ///   - failure: 失败回调
    /// - Returns: return
    static func requestList<M: Mappable, T: TargetType>
        (param: T,
         type: M.Type,
         provider: MoyaProvider<T>,
         success: ((_ list: [M]) -> ())?,
         failure: ((_ error: Error) -> ())?)
    {
        provider.rx.request(param)
            .asObservable()
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapArray(type: M.self)
            .subscribe(onNext: { (result) in
                success?(result)
            }, onError: { (error) in
                failure?(error)
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: bag)
    }
    
    
    /// 返回结果为model的请求
    /// - Parameters:
    ///   - param: 请求所需参数 示例 HotKeyListAPI.list(param: ["":""])
    ///   - type: 模型类型
    ///   - provider: provider
    ///   - success: 成功回调
    ///   - failure: 失败回调
    /// - Returns: return
    static func requestModel<M: Mappable, T: TargetType>
        (param: T,
         type: M.Type,
         provider: MoyaProvider<T>,
         success: ((_ model: M) -> ())?,
         failure: ((_ error: Error) -> ())?)
    {
        provider.rx.request(param)
            .asObservable()
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapModel(type: M.self)
            .subscribe(onNext: { (result) in
                success?(result)
            }, onError: { (error) in
                failure?(error)
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: bag)
    }
    
    
    /// 返回结果为list的请求: 根节点没有key值,极少用到
    /// - Parameters:
    ///   - param: 请求所需参数 示例 HotKeyListAPI.list(param: ["":""])
    ///   - type: 模型类型
    ///   - provider: provider
    ///   - success: 成功回调
    ///   - failure: 失败回调
    /// - Returns: return
    static func requestListWithoutKey<M: Mappable, T: TargetType>
        (param: T,
         type: M.Type,
         provider: MoyaProvider<T>,
         success: ((_ list: [M]) -> ())?,
         failure: ((_ error: Error) -> ())?)
    {
        provider.rx.request(param)
            .asObservable()
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapArrayWithoutKey(type: M.self)
            .subscribe(onNext: { (result) in
                success?(result)
            }, onError: { (error) in
                failure?(error)
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: bag)
    }
    
}

