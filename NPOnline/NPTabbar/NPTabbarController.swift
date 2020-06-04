//
//  NPTabbarController.swift
//  NPOnline
//
//  Created by 李永杰 on 2020/5/22.
//  Copyright © 2020 NewPath. All rights reserved.
//

import UIKit
import CYLTabBarController

let CYLTabBarControllerHeight: CGFloat = IS_X_LATER ? 83.0 : 49.0

class NPTabbarController: CYLTabBarController {
    
    static func initWithContext() -> NPTabbarController {
        let tabBarVC = NPTabbarController(viewControllers: NPTabbarController.viewControllers(), tabBarItemsAttributes: NPTabbarController.tabBarItemsAttributesForController())
        tabBarVC.customizeTabBarAppearance()
        return tabBarVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func viewControllers() -> [UINavigationController]{
        
        let home = NPNavigationController(rootViewController: NPHomeViewController())
        let course = NPNavigationController(rootViewController: NPCourseViewController())
        let community = NPNavigationController(rootViewController: NPCommunityViewController())
        let mine = NPNavigationController(rootViewController: NPMineViewController())
        let viewControllers = [home, course, community, mine]
        return viewControllers
    }
    
    static func tabBarItemsAttributesForController() ->  [[String : String]] {
        
        let itemHome = [CYLTabBarItemTitle:"首页",
                              CYLTabBarItemImage:"shouye",
                              CYLTabBarItemSelectedImage:"shouye"]
        let itemCourse = [CYLTabBarItemTitle:"课程",
                              CYLTabBarItemImage:"shouye",
                              CYLTabBarItemSelectedImage:"shouye"]
        let itemCommunity = [CYLTabBarItemTitle:"社区",
                              CYLTabBarItemImage:"shouye",
                              CYLTabBarItemSelectedImage:"shouye"]
        let itemMine = [CYLTabBarItemTitle:"我的",
                              CYLTabBarItemImage:"shouye",
                              CYLTabBarItemSelectedImage:"shouye"]
        let tabBarItemsAttributes = [itemHome, itemCourse, itemCommunity, itemMine]
        return tabBarItemsAttributes
    }
    
    func customizeTabBarAppearance() {
        self.tabBarHeight = CYLTabBarControllerHeight
        self.hideTabBarShadowImageView()
        self.tabBar.isTranslucent = false
        self.tabBar.theme_backgroundColor = "Tabbar.backgroundColor"
        self.tabBar.clipsToBounds = false
        self.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBar.layer.shadowRadius = 5.0
        self.tabBar.layer.shadowOpacity = 0.1
        self.tabBar.layer.masksToBounds = false
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13, *) {
            let currentUserInterfaceStyle = UITraitCollection.current.userInterfaceStyle
            guard currentUserInterfaceStyle != previousTraitCollection?.userInterfaceStyle else {
                return
            }
            let color = UIColor { (traitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    NPThemes.switchTo(.night)
                    print("监听--暗黑模式")
                    return .black
                } else {
                    NPThemes.switchTo(.normal)
                    print("监听--正常模式")
                    return .white
                }
            }
            self.view.backgroundColor = color
        } else {
            NPThemes.switchTo(.normal)
            print("不是iOS 13 ，不用适配暗黑模式")
        }
    }
     
}
