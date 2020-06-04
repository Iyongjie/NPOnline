//
//  Dictionay+Additional.swift
//  NPBaseKit
//
//  Created by 李永杰 on 2020/4/9.
//  Copyright © 2020 NewPath. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    /// 拼接字典
    /// - Parameter para: 新的字典
    /// - Returns: 拼接好的字典
    mutating func addDictionary(_ para:Dictionary?) -> Dictionary{
        if para != nil {
            for (key,value) in para! {
                self[key] = value
            }
        }
        return self
    }
    
    /// 是否有某个键
    /// - Parameter key: 键
    /// - Returns: 布尔值
    func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }
    
    /// 清空数组的所有键
    /// - Parameter keys: 清空数组的所有键
    mutating func removeAll(keys: [Key]) {
        keys.forEach({ removeValue(forKey: $0)})
    }
     
}
