//
//  Configuration.swift
//  NPBaseKit
//
//  Created by 李永杰 on 2020/4/8.
//  Copyright © 2020 NewPath. All rights reserved.
//

import Foundation
import Moya

public extension Network {
    
    class Configuration {
        
        public static var `default`: Configuration = Configuration()
        
        public var addingHeaders: (TargetType) -> [String: String] = { _ in [:] }
        
        public var replacingTask: (TargetType) -> Task = { $0.task }
        
        public var timeoutInterval: TimeInterval = 60
        
        public var plugins: [PluginType] = []
        
        public init() {}
    }
}
