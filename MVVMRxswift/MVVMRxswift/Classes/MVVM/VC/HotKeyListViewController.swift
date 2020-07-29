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
        HotKeyListViewModel.list(param: ["":""]) { (model) in
            debugPrint("id = \(String(describing: model.id)), hotkey = \(String(describing: model.hotkey)), function = \(String(describing: model.function))")
            
            debugPrint("json ===== \(model.toJSON())")
        }
    }

}
