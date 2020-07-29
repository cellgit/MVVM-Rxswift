//
//  ZJYGlobal.swift
//  MVVMRxswift
//
//  Created by 刘宏立 on 2020/7/29.
//  Copyright © 2020 刘宏立. All rights reserved.
//

import RxSwift

//释放池
let bag = DisposeBag()


class APIManager {
    /// 此接口用`vapor3`框架完成
    static let baseUrl = "https://kokora.herokuapp.com/"
}

/// API 管理类
class API: NSObject {
    /// sketch 快捷键
    static let SKETCH = "hotkeys"
}
