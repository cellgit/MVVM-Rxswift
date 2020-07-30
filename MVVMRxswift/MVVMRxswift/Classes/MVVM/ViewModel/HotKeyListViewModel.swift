//
//  HotKeyListViewModel.swift
//  MVVMRxswift
//
//  Created by 刘宏立 on 2020/7/29.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import Foundation
import RxSwift


/**
 * ViewModel类可被封装的 ZJYViewModel 所替代,具体到每一个请求ViewModel可废弃
 */
class HotKeyListViewModel: NSObject {
    
    // 获取列表
    #warning ("废弃")
    static func list(param:[String:Any], callback:((_ model: [HotKeyListModel])->())?) {
        HotKeyListAPIProvider.rx.request(HotKeyListAPI.list(param: ["":""]))
            .asObservable()
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapArrayWithoutKey(type: HotKeyListModel.self)
            .subscribe(onNext: { (result) in
                callback?(result)
            }, onError: { (error) in
                callback?([HotKeyListModel]())
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: bag)
    }
    
    
    /**
     * 获取 ZJYResultModel 的信息, ZJYResultModel为返回结果的公共字段
     */
//    static func list(param:[String:Any], callback:((_ isSuccess:Bool)->())?) {
//        HotKeyListAPIProvider.rx.request(HotKeyListAPI.list(param: ["":""]))
//            .asObservable()
//            .filterSuccessfulStatusCodes()
//            .mapJSON()
//            .mapModel(type: ZJYResultModel.self)
//            .subscribe(onNext: { (result) in
//
//                if result.errcode == 0 && (result.state == 0 || result.state == 1) {
//                    callback?(true)
//                }else {
//                    callback?(false)
//                }
//
//            }, onError: { (error) in
//                callback?(false)
//            }, onCompleted: nil, onDisposed: nil)
//            .disposed(by: bag)
//    }
}

