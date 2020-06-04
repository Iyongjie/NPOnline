//
//  UIButton+NPAdditional.swift
//  NPBaseKit
//
//  Created by 李永杰 on 2020/4/30.
//  Copyright © 2020 NewPath. All rights reserved.
//
import UIKit
import Foundation

public enum UIButtonEdgeInsetsStyle {
    case top                // 图片在文字上面
    case left               // 图片在文字左面
    case bottom             // 图片在文字下面
    case right              // 图片在文字右面
}

public extension UIButton {
    
    /// 布局重新布局
    /// - Parameters:
    ///   - style: 类型
    ///   - space: 间距
    func layoutButton(_ style: UIButtonEdgeInsetsStyle, _ space: CGFloat) {
        self.layoutIfNeeded()
        
        let imageWidth = self.imageView?.frame.width
        let imageHeight = self.imageView?.frame.height
        var labelWidth: CGFloat? = 0.0
        var labelHeight: CGFloat? = 0.0
        
        labelWidth = self.titleLabel?.intrinsicContentSize.width
        labelHeight = self.titleLabel?.intrinsicContentSize.height
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        switch style {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight! - space/2.0, left: 0, bottom: 0, right: -labelWidth!)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight! - space/2.0, right: 0)
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right:  space/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight! - space/2.0, right: -labelWidth!)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight! - space/2.0, left: -imageWidth!, bottom: 0, right: 0)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth! + space/2.0, bottom: 0, right: -labelWidth! - space/2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left:  -imageWidth! - space/2.0, bottom: 0, right: imageWidth! + space/2.0)
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
    
    // 扩大button点击热区
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {

        var bounds = self.bounds
        let widthDelta = max(44.0 - bounds.width, 0)
        let heightDelta = max(44.0 - bounds.height, 0)
        bounds = bounds.insetBy(dx: -0.5*widthDelta, dy: -0.5*heightDelta)
        return bounds.contains(point)
    }
}

extension UIButton {
    
}
