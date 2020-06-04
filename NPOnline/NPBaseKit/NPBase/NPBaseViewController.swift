//
//  NPBaseViewController.swift
//  NPBaseKit
//
//  Created by 李永杰 on 2020/4/10.
//  Copyright © 2020 NewPath. All rights reserved.
//

import UIKit
import SnapKit

open class NPBaseViewController: UIViewController {
    
    open var contentView = UIView()
    
    open var navigationBar = NPNavigationBar.npNavigtionBar()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.theme_backgroundColor = "Global.ViewControllerBackgroundColor"
        addContentView()
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    open func addNavigationBar() {
        self.view.addSubview(navigationBar)
    }
    
    open func removeNavigationBar() {
        self.navigationBar.removeFromSuperview()
    }
    
    open func addContentView() {
        contentView.backgroundColor = .white
        self.view.addSubview(contentView)
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let haveNavigationBar = self.navigationBar.superview != nil
        print("------\(haveNavigationBar)")
        if haveNavigationBar {
            navigationBar.snp.makeConstraints { (make) in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(kNavigationBarHeight)
            }
            contentView.snp.makeConstraints { (make) in
                make.top.equalTo(navigationBar.snp.bottom)
                make.left.bottom.right.equalToSuperview()
            }
        } else {
            contentView.snp.makeConstraints { (make) in
                make.top.left.bottom.right.equalToSuperview()
            }
        }
    }
    
    open override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
}
