//
//  NPTopAliginLabel.swift
//  NPOnline
//
//  Created by 李永杰 on 2020/5/27.
//  Copyright © 2020 NewPath. All rights reserved.
//
// 文字从左上角开始的label

import UIKit

class NPTopAliginLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        textRect.origin.y = bounds.origin.y
        return textRect
    }
    
    override func drawText(in rect: CGRect) {
        let actualRect = self.textRect(forBounds: rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawText(in: actualRect)
    }
}
