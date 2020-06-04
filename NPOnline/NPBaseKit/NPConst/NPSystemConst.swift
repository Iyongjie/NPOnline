//
//  NPSystemConst.swift
//  NPDemoProject
//
//  Created by 李永杰 on 2020/3/11.
//  Copyright © 2020 NewPath. All rights reserved.
//

import Foundation
import UIKit

// MARK: 系统相关
public let kAppBundleInfoVersion = Bundle.main.infoDictionary ?? Dictionary()
// MARK: APP版本号
public let kAppVersion = (kAppBundleInfoVersion["CFBundleShortVersionString" as String] as? String ) ?? ""
public let kAppBundleBuild = (kAppBundleInfoVersion["CFBundleVersion"] as? String ) ?? ""
public let kAppDisplayName = (kAppBundleInfoVersion["CFBundleDisplayName"] as? String ) ?? ""

// MARK: 系统版本
public let kVersion = (UIDevice.current.systemVersion as NSString).floatValue
public let kIOS_Base = 8.0
public let kIOS8_OR_LATER = ( (Double(UIDevice.current.systemVersion) ?? kIOS_Base) >= 8.0 ) ? true : false;
public let kIOS9_OR_LATER = ((Double(UIDevice.current.systemVersion) ?? kIOS_Base) >= 9.0 ) ? true : false;
public let kIOS10_OR_LATER = ((Double(UIDevice.current.systemVersion) ?? kIOS_Base) >= 10.0 ) ? true : false;
public let kIOS11_OR_LATER = ((Double(UIDevice.current.systemVersion) ?? kIOS_Base) >= 11.0 ) ? true : false;
public let kIOS12_OR_LATER = ((Double(UIDevice.current.systemVersion) ?? kIOS_Base) >= 12.0 ) ? true : false;
public let kIOS13_OR_LATER = ((Double(UIDevice.current.systemVersion) ?? kIOS_Base) >= 13.0 ) ? true : false;
