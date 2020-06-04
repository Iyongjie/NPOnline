//
//  NPDeviceConst.swift
//  NPDemoProject
//
//  Created by 李永杰 on 2020/3/11.
//  Copyright © 2020 NewPath. All rights reserved.
//

import Foundation
import UIKit

/// 屏幕宽度
public let k_ScreenWidth = UIScreen.main.bounds.size.width
/// 屏幕高度
public let k_ScreenHeight = UIScreen.main.bounds.size.height
/// 屏幕大小
public let k_ScreenSize = UIScreen.main.bounds

/// 判断是否为iPhone
public let k_IS_iPhone = (UI_USER_INTERFACE_IDIOM() == .phone)
/// 判断是否为iPad
public let k_IS_iPad = (UI_USER_INTERFACE_IDIOM() == .pad)
///机型判断
public let kSCREEN_MAX_LENGTH  = max(k_ScreenWidth, k_ScreenHeight)
public let k_iPhone5 = (k_IS_iPhone && kSCREEN_MAX_LENGTH == 568.0)
public let k_iPhone6 = (k_IS_iPhone && kSCREEN_MAX_LENGTH == 667.0)
public let k_iPhonePLUS = (k_IS_iPhone && kSCREEN_MAX_LENGTH == 736.0)
public let k_iPhoneX=__CGSizeEqualToSize(CGSize.init(width: 1125/3, height: 2436/3), UIScreen.main.bounds.size)
public let k_iPhoneXr=__CGSizeEqualToSize(CGSize.init(width: 828/2, height: 1792/2), UIScreen.main.bounds.size)
public let k_iPhoneXs=__CGSizeEqualToSize(CGSize.init(width: 1125/3, height: 2436/3), UIScreen.main.bounds.size)
public let k_iPhoneXs_Max=__CGSizeEqualToSize(CGSize.init(width: 1242/3, height: 2688/3), UIScreen.main.bounds.size)
public let IS_X_LATER = (k_iPhoneX||k_iPhoneXr||k_iPhoneXs||k_iPhoneXs_Max)
 
//获取状态栏、标题栏、导航栏高度
public let kStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
public let kNavigationBarHeight: CGFloat =  IS_X_LATER ? 88 : 64
public let KTabBarHeight: CGFloat = IS_X_LATER ? 83 : 49

/// 缩放比例
public let kScaleNum = (k_ScreenWidth/750)
public func kScaleNumCeilf(x: Float) -> (Float) {
    return (ceilf(x * Float(kScaleNum)))
}
