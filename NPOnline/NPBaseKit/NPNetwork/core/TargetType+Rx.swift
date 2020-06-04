//
//  TargetType+Rx.swift
//  NPBaseKit
//
//  Created by 李永杰 on 2020/4/8.
//  Copyright © 2020 NewPath. All rights reserved.
//

import RxSwift
import Moya

public extension TargetType {
    
    func request() -> Single<Moya.Response> {
        return Network.default.provider.rx.request(.target(self))
    }
}
