//
//  Extension+UIBarButtonItem.swift
//  HabitsKeeper
//
//  Created by MarcosMeng on 25/12/2019.
//  Copyright © 2014 MarcosMeng. All rights reserved.
//

import UIKit

public extension UIViewController {
    enum NavigationBarItemPosition {
        case left
        case right
    }

    @discardableResult func configNavBtn(position: NavigationBarItemPosition = .left, _ img: UIImage?, action: Selector) -> UIBarButtonItem {
        let btn = UIButton(type: .custom)
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: action, for: .touchUpInside)
        let navBtn = UIBarButtonItem(customView: btn)
        switch position {
        case .right:
            navigationItem.rightBarButtonItem = navBtn
        default:
            navigationItem.leftBarButtonItem = navBtn
        }
        return navBtn
    }
}

public extension UITabBar {
    func invisibleLine() {
        if #available(iOS 13, *) {
            let appearance = standardAppearance
            appearance.backgroundImage = UIImage()
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .clear
            standardAppearance = appearance
        } else {
            shadowImage = UIImage()
            backgroundImage = UIImage()
        }
    }
}
