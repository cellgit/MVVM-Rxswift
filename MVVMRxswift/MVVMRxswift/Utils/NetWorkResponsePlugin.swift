//
//  NetWorkResponsePlugin.swift
//  Life on Road
//
//  Created by 刘宏立 on 2020/7/28.
//  Copyright © 2020 S.S.S.S.S.S.S.S. All rights reserved.
//

//MARK: 对网络请求 返回进行不同的逻辑处理
import Foundation

import UIKit
import Moya
//import enum Result.Result
//import Result
//import MBProgressHUD

public struct NetWorkResponsePlugin:PluginType {
    
    
    //请求即将发送
    public func willSend(_ request: RequestType, target: TargetType) {
        print(request.request ?? "")
    }
    
    //收到服务器返回
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
        //处理 返回信息
        switch result {
        case .success(let response):
            
            //打印请求地址
            print("********" + target.path + "********\n" + "success")
            
            ///截取返回数据
            do{
                let any = try response.mapJSON()
                //打印返回的数据
                print(any)
            }catch {
                print("Catch.......")
            }
            
            //处理返回数据信息状态
            self.handleResult(response, path: target.path)
            
        case .failure(let error):
//            MBProgressHUD().hide(animated: true)
            //似乎已断开与互联网的连接
            print(error.localizedDescription)
            //打印请求及错误信息
            print("!!!!!!!!" + target.path + "!!!!!!!!\n" + "error:" + error.localizedDescription)
            
        }
    }
    
    //MARK:处理返回数据信息状态
    fileprivate func handleResult(_ response:Response,path:String) {
        debugPrint("response === \(response)")
        guard let dict = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] else {
            print("返回数据解析失败")
            return
        }
        
        let error:String = dict["errmsg"] as? String ?? ""
        let stateCode:Int = dict["state"] as? Int ?? 0
        
        //TODO:对异常的处理  以及特殊情况的处理
        //{
        //    "errmsg" : "需要登录",
        //    "res" : {
        //        "list" : null
        //    },
        //    "errcode" : 0,
        //    "state" : -100,
        //    "version" : 1
        //}
        // -1,-10,-100
        // -100需要登录
        // -10取消订单失败
        // -1 提示信息
        
        //1.需要登录时
        if error.elementsEqual("需要登录") || error.elementsEqual("登录已过期") {
//            //1.清本地缓存
//            VolunteerLoginViewModel.volunteerClearLoginUserInfo()
//            UserModel.singleton()?.logout()
//            NotificationCenter.default.post(Notification(name: KNotificationName.logoutRefresh))
            //2.跳转到到登录界面
            //如果是校验是否购买了aigo就不再跳转到登录/index.php?r=users/is-can-try
            if response.request?.url?.absoluteString.contains("r=users/judge-login") ?? false  {
               return
            }
           
            if  let vc = UIApplication.shared.keyWindow?.rootViewController {
//                let loginVC = LoginVC()
//                let nav = NavigationViewController.init(rootViewController: loginVC)
//                vc.present(nav, animated: true, completion: nil)
                
            }
        }
        
        //2.取消订单
        if stateCode == -10 {
            
        }
        
        //3.-1提示信息
        if stateCode == -1 {
//            MBProgressHUD.toast(error)
//            EntryKitTool.showToast(des: error)
        }
    }
}

