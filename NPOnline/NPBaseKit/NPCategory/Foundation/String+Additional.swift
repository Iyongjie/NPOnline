//
//  String+Additional.swift
//  NPDemoProject
//
//  Created by 李永杰 on 2020/3/31.
//  Copyright © 2020 NewPath. All rights reserved.
//

import Foundation
import UIKit
public extension String {
    
    /// 字符串高度
    /// - Parameters:
    ///   - font: 字体
    ///   - fixedWidth: 固定宽度
    /// - Returns: 高度
    func heightWithFont(font : UIFont, fixedWidth : CGFloat) -> CGFloat {
        
        guard count > 0 && fixedWidth > 0 else {
            return 0
        }
       
        let rect = NSString(string: self).boundingRect(with: CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return rect.size.height
    }
    
    /// 字符串宽度
    /// - Parameters:
    ///   - font: 字体
    ///   - fixedHeight: 固定高度
    /// - Returns: 宽度
    func widthWithFont(font : UIFont, fixedHeight : CGFloat) -> CGFloat {
        
        guard count > 0 && fixedHeight > 0 else {
            return 0
        }
       
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: fixedHeight), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return rect.size.width
    }
}
