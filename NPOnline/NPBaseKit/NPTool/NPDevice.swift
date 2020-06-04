//
//  NPDevice.swift
//  NPBaseKit
//
//  Created by 李永杰 on 2020/4/27.
//  Copyright © 2020 NewPath. All rights reserved.
//

import Foundation
import CoreTelephony

/// 是否安装SIM卡
/// - Returns: 布尔
public func isSIMInstalled() -> Bool {
    let info = CTTelephonyNetworkInfo()
    let carrier = info.subscriberCellularProvider
    if ((carrier?.isoCountryCode) != nil) {
        return true
    } else {
        return false
    }
}
