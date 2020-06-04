//
//  UIView+NPAdditional.swift
//  NPBaseKit
//
//  Created by 李永杰 on 2020/4/29.
//  Copyright © 2020 NewPath. All rights reserved.
//

import UIKit
import Foundation

public enum UIViewDashLineDirection {
    case horizontal
    case vertical
}

public extension UIView {
    
    /// 自定义圆角
    /// - Parameters:
    ///   - rect: 圆角位置 eg: [.topLeft, .topRight]
    ///   - radius: 圆角半径
    func makeCorner(_ rect: UIRectCorner, _ radius: CGFloat) {
        self.layoutIfNeeded()//这句代码很重要，不能忘了
        
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: rect, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        self.layer.masksToBounds = true
    }
    
    /// 设置阴影
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - opacity: 透明度
    ///   - shadowRadius: 阴影模糊半径
    func makeShadow(_ color: UIColor, _ opacity: Float, _ shadowRadius: CGFloat) {
        self.layoutIfNeeded()
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shouldRasterize = false
        self.layer.shadowPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: 0).cgPath
        self.layer.masksToBounds = false
    }
    
    /// 添加任意边框
    /// - Parameters:
    ///   - top: 上
    ///   - left: 左
    ///   - bottom: 下
    ///   - right: 右
    ///   - borderColor: 边框颜色
    ///   - borderWidth: 边框宽度
    func makeBorder(_ top: Bool, _ left: Bool, _ bottom: Bool, _ right: Bool, _ borderColor: UIColor, _ borderWidth: CGFloat) {
        self.layoutIfNeeded()
        
        if top {
            let layer = CALayer()
            layer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: borderWidth)
            layer.backgroundColor = borderColor.cgColor
            self.layer.addSublayer(layer)
        }
        if left {
            let layer = CALayer()
            layer.frame = CGRect(x: 0, y: 0, width: borderWidth, height: self.frame.height)
            layer.backgroundColor = borderColor.cgColor
            self.layer.addSublayer(layer)
        }
        if bottom {
            let layer = CALayer()
            layer.frame = CGRect(x: 0, y: self.frame.height - borderWidth, width: self.frame.width, height: borderWidth)
            layer.backgroundColor = borderColor.cgColor
            self.layer.addSublayer(layer)
        }
        if right {
            let layer = CALayer()
            layer.frame = CGRect(x: self.frame.width - borderWidth, y: 0, width: borderWidth, height: self.frame.height)
            layer.backgroundColor = borderColor.cgColor
            self.layer.addSublayer(layer)
        }
    }
}
