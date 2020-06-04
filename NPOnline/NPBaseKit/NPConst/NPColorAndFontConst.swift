//
//  NPColorAndFontConst.swift
//  NPDemoProject
//
//  Created by 李永杰 on 2020/3/11.
//  Copyright © 2020 NewPath. All rights reserved.
//


import Foundation
import UIKit

public let kAppMainColor = HexColorAlpha("#2878FF")
public let kFontRegular = "PingFangSC-Regular"
public let kFontSemiBold = "PingFangSC-Semibold"

// MARK: 十六进制字符串设置颜色, 示例HexColorAlpha("#2878FF")
public func HexColorAlpha(_ hexString: String, _ alpha: Float = 1) -> UIColor {
    return UIColor(hexString: hexString)!
}
// MARK: 通过 red 、 green 、blue 、alpha 颜色数值
public func RGBAlpa(r: Float, g: Float, b: Float, a: Float = 1) -> UIColor {
    return UIColor.init(red: CGFloat(CGFloat(r)/255.0), green: CGFloat(CGFloat(g)/255.0), blue: CGFloat(CGFloat(b)/255.0), alpha: CGFloat(a))
}
 
/// 加粗字体
/// - Parameters:
///   - iphone: iPhone字体大小
///   - ipad: iPad字体大小，有默认值可省略
/// - Returns: 字体
public func kFontSemiboldSize(_ iphone: CGFloat, _ ipad: CGFloat = 20) -> UIFont {
    return UIFont(name: kFontSemiBold, size: k_IS_iPad ? ipad : iphone)!
}

// 常规字体
public func kFontRegularSize(_ iphone: CGFloat, _ ipad: CGFloat = 20) -> UIFont {
    return UIFont(name: kFontRegular, size: k_IS_iPad ? ipad : iphone)!
}
