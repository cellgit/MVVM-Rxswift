//
//  HotKeyListViewController.swift
//  MVVMRxswift
//
//  Created by 刘宏立 on 2020/7/29.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import UIKit

class HotKeyListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadData()
    }
    
    private func loadData() {
        let param = HotKeyListAPI.list(param: ["":""])
        ZJYViewModel.requestListWithoutKey(param: param, type: HotKeyListModel.self, provider: HotKeyListAPIProvider, success: { (list) in
            debugPrint("list======\(String(describing: list.toJSONString()))")
        }) { (error) in
            debugPrint("======= \(error)")
        }
    }

}
