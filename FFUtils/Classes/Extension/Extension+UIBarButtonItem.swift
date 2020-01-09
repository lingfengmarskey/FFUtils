//
//  Extension+UIBarButtonItem.swift
//  HabitsKeeper
//
//  Created by MarcosMang on 25/12/2019.
//  Copyright © 2019 MarcosMang. All rights reserved.
//

import UIKit

extension UIViewController {
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

extension UITabBar {
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
