//
//  NPNavigtionBar.swift
//  Demo
//
//  Created by 李永杰 on 2020/5/11.
//  Copyright © 2020 NewPath. All rights reserved.
//

import UIKit
import Foundation
import SnapKit
 
public func kNPNavigationBarTop() -> CGFloat {
    var statusBarHeight: CGFloat = 0
//    if #available(iOS 13.0, *) {
//        let statusManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
//        statusBarHeight = CGFloat((statusManager?.statusBarFrame.height)!)
//    } else {
//        statusBarHeight = UIApplication.shared.statusBarFrame.size.height
//    }
    statusBarHeight = UIApplication.shared.statusBarFrame.size.height

    return statusBarHeight
}
public let kNPNavigationBarHeight = (kNPNavigationBarTop() + 44.0)
let kNPNavigationScreenWidth = UIScreen.main.bounds.size.width
let kNPNavigationScreenHeight = UIScreen.main.bounds.size.height
let kNPNavigationContentHeight: CGFloat = 44.0
let kNPNavigationBTNWidth: CGFloat = 44.0
let kNPNavigationBTNHeight: CGFloat = 44.0

/// 点击事件
@objc protocol NPNavigationBarDelegate {
    func didClickNavigationWithTag(tag: NSInteger)
}

@objc protocol NPNavigationDataSource {
    func createNavigationView() -> UIView
}

/// 导航栏排版类型
public enum NPNavigationBarStyle {
    case all
    case left
    case leftAndMiddle
    case leftAndRight
    case middle
    case middleAndRight
    case right
}
 
/// 动态添加的位置
public enum NPNavigationBarItemPosition {
    case left
    case right
}

/// tag左边从423开始，右边从523开始
public enum NPNavigationBarItemTag: NSInteger {
    case left = 423
    case right = 523
}

public class NPNavigationBar: UIView {
    // MARK: 公开属性
    var title: String? {
        didSet {
            middleLabel.text = title
            for (_, view) in middleView.subviews.enumerated() {
                view.removeFromSuperview()
            }
            addMiddleView()
        }
    }
    var titleColor: UIColor? = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1) {
        didSet {
            middleLabel.textColor = titleColor
        }
    }
    var titleFont: UIFont? = UIFont(name: "PingFangSC-Semibold", size: 18) {
        didSet {
            self.middleWidth = self.calculateWidthWithFont(string: middleLabel.text!)
            middleLabel.font = titleFont
        }
    }
    var lineColor: UIColor? = UIColor(red: 218/255.0, green: 218/255.0, blue: 218/255.0, alpha: 1) {
        didSet {
            self.lineView.backgroundColor = lineColor!
        }
    }
    var leftItems: [UIButton]? {
        didSet {
            for (_, view) in self.leftView.subviews.enumerated() {
                view.removeFromSuperview()
            }
            addLeftViewItems()
        }
    }
    var rightItems: [UIButton]? {
        didSet {
            for (_, view) in self.rightView.subviews.enumerated() {
                view.removeFromSuperview()
            }
            addRightViewItems()
        }
    }
    
    var hiddenLineView: Bool? = true {
        didSet {
            self.lineView.isHidden = hiddenLineView!
        }
    }
    var style: NPNavigationBarStyle? {
        didSet {
            switch style! {
            case .all:
                self.addLeftViewItems()
                self.addMiddleView()
                self.addRightViewItems()
                break
            case .left:
                self.middleView.removeFromSuperview()
                self.rightView.removeFromSuperview()
                self.addLeftViewItems()
                break
            case .leftAndMiddle:
                self.rightView.removeFromSuperview()
                self.addLeftViewItems()
                self.addMiddleView()
                break
            case .leftAndRight:
                self.middleView.removeFromSuperview()
                self.addLeftViewItems()
                self.addRightViewItems()
                break
            case .middle:
                self.leftView.removeFromSuperview()
                self.rightView.removeFromSuperview()
                self.addSubview(middleView)
                break
            case .middleAndRight:
                self.leftView.removeFromSuperview()
                self.addMiddleView()
                self.addRightViewItems()
                break
            case .right:
                self.leftView.removeFromSuperview()
                self.middleView.removeFromSuperview()
                self.addRightViewItems()
                break
            }
        }
    }

    weak var delegate: NPNavigationBarDelegate?
    weak var dataSource: NPNavigationDataSource? {
        didSet {
            for (_, view) in self.contentView.subviews.enumerated() {
                view.removeFromSuperview()
            }
            self.contentView.addSubview((dataSource?.createNavigationView())!)
        }
    }
     
    // MARK: 公开方法
    func setBackgroundColor(backgroundColor: UIColor) {
        self.backgroundView.isHidden = false
        self.backgroundView.backgroundColor = backgroundColor
        self.backgroundImageView.isHidden = true
    }
    
    func setBackgroundImageName(name: String) {
        self.backgroundImageView.isHidden = false
        self.backgroundImageView.image = UIImage(named: name)
        self.backgroundView.isHidden = true
    }
    
    func setBackAlpha(alpha: CGFloat, onlyeBack: Bool) {
        if onlyeBack {
            self.backgroundView.alpha = alpha
            self.backgroundImageView.alpha = alpha
            self.lineView.alpha = alpha
        } else {
            for (_, view) in self.subviews.enumerated() {
                view.alpha = alpha
            }
        }
    }
    
    func addItemWithPosition(position: NPNavigationBarItemPosition, item: UIButton) {
        if position == .left {
            self.leftItems?.append(item)
            self.addLeftViewItems()
        }else{
            self.rightItems?.append(item)
            self.addRightViewItems()
        }
    }
    
    func setItem(tag: NSInteger, title: String, titleColor: UIColor, backgroundColor: UIColor, font: UIFont, radius: CGFloat, state: UIControl.State) {
        let contentView = tag < 523 ? self.leftView : self.rightView
        let btn = contentView.viewWithTag(tag) as! UIButton
        btn.setImage(nil, for: .normal)
        self.setBtn(btn: btn, title: title, titleColor: titleColor, backgroundColor: backgroundColor, font: font, radius: radius, state: state)
        if tag < 523 {
            self.leftWidth = 0
            for index in 0..<self.leftItems!.count {
                let item = self.leftItems![index]
                let width = item.frame.width != 0 ? item.frame.width : kNPNavigationBTNWidth
                self.leftWidth += width
            }
        } else {
            self.rightWidth = 0
            for index in 0..<self.rightItems!.count {
                let item = self.rightItems![index]
                let width = item.frame.width != 0 ? item.frame.width : kNPNavigationBTNWidth
                self.rightWidth += width
            }
        }
    }
     
    func setItem(tag: NSInteger, imageName: String, edgInset: UIEdgeInsets, state: UIControl.State) {
        let contentView = tag < 523 ? self.leftView : self.rightView
        let btn = contentView.viewWithTag(tag) as! UIButton
        btn.setImage(UIImage(named: imageName), for: state)
        btn.imageEdgeInsets = edgInset
        self.setBtn(btn: btn, title: "", titleColor: UIColor(), backgroundColor: UIColor.clear, font: UIFont(), radius: 0, state: state)
    }
    
    func addHeaderView(view: UIView) {
        self.middleLabel.removeFromSuperview()
        self.middleView.addSubview(view)
    }
    
    // MARK: 初始化
    class func npNavigtionBar() -> NPNavigationBar{
        let navigationBar = NPNavigationBar(frame: CGRect(x: 0, y: 0, width: kNPNavigationScreenWidth, height: kNPNavigationBarHeight))
        navigationBar.backgroundColor = .clear
        navigationBar.backgroundView.backgroundColor = .white
        navigationBar.backgroundImageView.isHidden = true
        navigationBar.title = "title"
        let backBtn = UIButton(type: .custom)
        backBtn.setTitle("left", for: .normal)
        navigationBar.leftItems = [backBtn]
        let rightBtn = UIButton(type: .custom)
        rightBtn.setTitle("right", for: .normal)
        navigationBar.rightItems = [rightBtn]
        navigationBar.style = .all
        return navigationBar
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: 私有方法
    private func configUI() {
        self.addSubview(backgroundView)
        self.addSubview(backgroundImageView)
        self.addSubview(contentView)
        // 完全自定义view
        if dataSource != nil {
            contentView.addSubview((dataSource?.createNavigationView())!)
        } else {
            contentView.addSubview(leftView)
            contentView.addSubview(middleView)
            contentView.addSubview(rightView)
        }
        contentView.addSubview(lineView)
    }
    
    private func addLeftViewItems() {
        // 只要width
        if leftView.superview == nil {
            self.contentView.addSubview(self.leftView)
        }
        self.leftWidth = 0
        for index in 0..<self.leftItems!.count {
            let item = self.leftItems![index]
            let width = item.frame.width != 0 ? item.frame.width : kNPNavigationBTNWidth
            self.leftWidth += width
            item.addTarget(self, action: #selector(clickLeftOrRightBtn(btn:)), for: .touchUpInside)
            item.tag = NPNavigationBarItemTag.left.rawValue + index
            self.leftView.addSubview(item)
        }
    }
    
    private func addMiddleView() {
        if middleView.superview == nil {
            self.contentView.addSubview(self.middleView)
        }
        self.middleWidth = self.calculateWidthWithFont(string: middleLabel.text!)
        middleView.addSubview(middleLabel)
    }
    
    private func addRightViewItems() {
        if rightView.superview == nil {
            self.contentView.addSubview(self.rightView)
        }
        self.rightWidth = 0
        for index in 0..<self.rightItems!.count {
            let item = self.rightItems![index]
            let width = item.frame.width != 0 ? item.frame.width : kNPNavigationBTNWidth
            self.rightWidth += width
            item.addTarget(self, action: #selector(clickLeftOrRightBtn(btn:)), for: .touchUpInside)
            item.tag = NPNavigationBarItemTag.right.rawValue + index
            self.rightView.addSubview(item)
        }
    }
    
    private func setBtn(btn: UIButton, title: String, titleColor: UIColor, backgroundColor: UIColor, font: UIFont, radius: CGFloat, state: UIControl.State) {
        btn.setTitle(title, for: state)
        btn.setTitleColor(titleColor, for: state)
        btn.setBackgroundImage(UIImage(navigationBackgroundColor: backgroundColor, size: btn.frame.size), for: state)
        btn.layer.cornerRadius = radius
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = font
    }
    
    @objc private func clickLeftOrRightBtn(btn: UIButton) {
        delegate?.didClickNavigationWithTag(tag: btn.tag)
    }
    
    func calculateWidthWithFont(string: String) -> CGFloat {
        guard string.count > 0 else {
            return 0
        }
        let rect = NSString(string: string).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: kNPNavigationContentHeight), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: titleFont!], context: nil)
        return rect.width + 10
    }
    
    // MARK: 私有属性
    private lazy var backgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var leftView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var middleView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var middleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = titleFont
        label.textColor = titleColor
        return label
    }()
    
    private lazy var rightView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = lineColor
        return view
    }()
    
    private var leftWidth: CGFloat = 0
    private var middleWidth: CGFloat = 0
    private var rightWidth: CGFloat = 0
     
    /// 布局
    public override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.snp.remakeConstraints { (make) in
            make.edges.equalTo(0)
        }
        backgroundImageView.snp.remakeConstraints { (make) in
            make.edges.equalTo(0)
        }
        contentView.snp.remakeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(kNPNavigationContentHeight)
        }
        // 不是完全自定义
        if self.dataSource == nil {
            
            // 左边
            if leftView.superview != nil {
                leftView.snp.remakeConstraints { (make) in
                    make.left.top.bottom.equalTo(0)
                    make.width.equalTo(self.leftWidth)
                }
                var alignLeftItem = leftView.snp.left
                for index in 0..<self.leftItems!.count {
                    let item = self.leftItems![index]
                    let width = item.bounds.width == 0 ? kNPNavigationBTNWidth : item.bounds.width
                    item.snp.remakeConstraints { (make) in
                        make.top.bottom.equalToSuperview()
                        make.left.equalTo(alignLeftItem)
                        make.width.equalTo(width)
                        make.height.equalTo(kNPNavigationBTNHeight)
                    }
                    alignLeftItem = item.snp.right
                }
            }
            if middleView.superview != nil {
                let headerView = middleView.subviews[0]
                let width = headerView.frame.width > 0 ? headerView.frame.width : self.middleWidth
                self.middleWidth = width
                // 中间
                let headerWidth = self.middleWidth > 0 ? self.middleWidth : kNPNavigationScreenWidth/3*2.0
                middleView.snp.remakeConstraints { (make) in
                    make.top.bottom.equalTo(0)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(headerWidth)
                }
                let view = middleView.subviews[0]
                view.snp.remakeConstraints { (make) in
                    make.edges.equalToSuperview()
                }
            }
            if rightView.superview != nil {
                // 右
                rightView.snp.remakeConstraints { (make) in
                    make.right.top.bottom.equalTo(0)
                    make.width.equalTo(self.rightWidth)
                }
                
                var alignRightItem = rightView.snp.left
                for index in 0..<self.rightItems!.count {
                    let item = self.rightItems![index]
                    let width = item.bounds.width == 0 ? kNPNavigationBTNWidth : item.bounds.width
                    item.snp.remakeConstraints { (make) in
                        make.top.bottom.equalToSuperview()
                        make.left.equalTo(alignRightItem)
                        make.width.equalTo(width)
                        make.height.equalTo(kNPNavigationBTNHeight)
                    }
                    alignRightItem = item.snp.right
                }
            }
        } else {
            let view = self.contentView.subviews[0]
            view.snp.remakeConstraints { (make) in
                make.edges.equalTo(0)
            }
        }
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}

extension UIImage {
    convenience init(navigationBackgroundColor: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        navigationBackgroundColor.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            self.init()
            return
        }
        UIGraphicsEndImageContext()
        guard let aCgImage = image.cgImage else {
            self.init()
            return
        }
        self.init(cgImage: aCgImage)
    }
}
