//
//  NPDebug.swift
//  NPBaseKit
//
//  Created by 李永杰 on 2020/4/22.
//  Copyright © 2020 NewPath. All rights reserved.
//

import Foundation
import CocoaDebug

//normal print
public func print<T>(file: String = #file, function: String = #function, line: Int = #line, _ message: T, color: UIColor = .white) {
    #if DEBUG
    swiftLog(file, function, line, message, color, false)
    #endif
}
//unicode print
public func print_UNICODE<T>(file: String = #file, function: String = #function, line: Int = #line, _ message: T, color: UIColor = .white) {
    #if DEBUG
    swiftLog(file, function, line, message, color, true)
    #endif
}
