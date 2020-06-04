//
//  NPThemes.swift
//  NPBaseKit
//
//  Created by 李永杰 on 2020/5/9.
//  Copyright © 2020 NewPath. All rights reserved.
//
 
import Foundation
import SwiftTheme

public enum NPThemes {
    
    case normal
    case night
    
    static var current = NPThemes.normal
    static var before  = NPThemes.normal
     
    // MARK: - Switch Theme
    public static func switchTo(_ theme: NPThemes) {
        before  = current
        current = theme
        
        switch theme {
            case .normal :
                ThemeManager.setTheme(jsonName: "Normal_theme", path: .mainBundle)
            case .night :
                ThemeManager.setTheme(jsonName: "Night_theme", path: .mainBundle)
        }
    }
    
    static func isNight() -> Bool {
        return current == .night
    }
}
