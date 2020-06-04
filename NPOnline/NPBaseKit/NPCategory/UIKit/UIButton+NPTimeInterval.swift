//
//  UIButton+NPTimeInterval.swift
//  NPBaseKit
//
//  Created by 李永杰 on 2020/5/13.
//  Copyright © 2020 NewPath. All rights reserved.
//
/*
 1. 防止暴力点击
 2. 两种模式，时间等待模式，默认间隔为1秒，也可以设置计算属性clickDurationTime
 3. 事件完成模式，手动控制按钮是否可以点击
 buyBtn.repeatButtonClickType = .eventDone
 sender.isFinishEvent = true
 模拟网络请求回调
 DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 5) {
 print("可以用了")
 sender.isFinishEvent = false
 }
 */
import Foundation
import UIKit

let defaultDuration: TimeInterval = 1

public extension UIButton{
    @objc func my_sendAction(action: Selector, to target: AnyObject?, forEvent event: UIEvent?) {
        
        if (self.isKind(of: UIButton.self)) {
            
            switch self.repeatButtonClickType {
            case .durationTime:
                clickDurationTime = clickDurationTime == 0 ? defaultDuration : clickDurationTime
                
                if isIgnoreEvent {
                    return
                } else if clickDurationTime > 0 {
                    isIgnoreEvent = true
                    // 在过了我们设置的duration之后，再将isIgnoreEvent置为false
                    DispatchQueue.global(qos: .default).asyncAfter(deadline: DispatchTime.now() + clickDurationTime) {
                        self.isIgnoreEvent = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + clickDurationTime) {
                        self.isIgnoreEvent = false
                    }
                    my_sendAction(action: action, to: target, forEvent: event)
                }
            case .eventDone:
                
                if !isFinishEvent {
                    my_sendAction(action: action, to: target, forEvent: event)
                    isFinishEvent = true
                }
            }
        } else {
            my_sendAction(action: action, to: target, forEvent: event)
        }
    }
}

public enum RepeatButtonClickType : Int{
    case durationTime = 0
    case eventDone
}

public extension UIButton {
    
    struct AssociatedKeys {
        static var clickDurationTime = "my_clickDurationTime"
        static var isIgnoreEvent = "my_isIgnoreEvent"
        static var isFinish = "my_isFinish"
        static var repeatButtonClickType = "repeatButtonClickType"
    }
    
    var repeatButtonClickType : RepeatButtonClickType {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.repeatButtonClickType, newValue as RepeatButtonClickType, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let clickDurationTime = objc_getAssociatedObject(self, &AssociatedKeys.repeatButtonClickType) as? RepeatButtonClickType {
                return clickDurationTime
            }
            return .durationTime
        }
    }
    
    // 点击间隔时间
    var clickDurationTime : TimeInterval {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.clickDurationTime, newValue as TimeInterval, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let clickDurationTime = objc_getAssociatedObject(self, &AssociatedKeys.clickDurationTime) as? TimeInterval {
                return clickDurationTime
            }
            return defaultDuration
        }
    }
    // 是否忽视点击事件
    var isIgnoreEvent : Bool {
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isIgnoreEvent, newValue as Bool, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let isIgnoreEvent = objc_getAssociatedObject(self, &AssociatedKeys.isIgnoreEvent) as? Bool {
                return isIgnoreEvent
            }
            return false
        }
    }
    
    // 是否完成点击事件
    var isFinishEvent : Bool {
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isFinish, newValue as Bool, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            
            if let isFinishEvent = objc_getAssociatedObject(self, &AssociatedKeys.isFinish) as? Bool {
                return isFinishEvent
            }
            return false
        }
    }
    
    class func initializeOnceMethod() {
        
        if self !== UIButton.self {
            return
        }
        DispatchQueue.once(token: "jcgf.swift-Carsh-test-Crash"){
            
            let originalSelector = #selector(UIButton.sendAction)
            let swizzledSelector = #selector(UIButton.my_sendAction(action:to:forEvent:))
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            // 运行时为类添加我们自己写的my_sendAction(_:to:forEvent:)
            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
            
            if didAddMethod {
                // 如果添加成功，则交换方法
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
            } else {
                // 如果添加失败，则交换方法的具体实现
                method_exchangeImplementations(originalMethod!, swizzledMethod!)
            }
        }
    }
}

public extension DispatchQueue {
    
    private static var _onceTracker = "Stringss"
    
    class func once(token: String, block: () -> ()) {
        
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if _onceTracker.contains(token) {
            
            return
        }
        _onceTracker.append(token)
        block()
    }
    
    func async(block: @escaping ()->()) {
        
        self.async(execute: block)
    }
    
    func after(time: DispatchTime, block: @escaping ()->()) {
        
        self.asyncAfter(deadline: time, execute: block)
    }
}
