//
//  Extension+UIViewController.swift
//  HabitsKeeper
//
//  Created by fenrir Marcos Meng on 2020/1/6.
//  Copyright © 2020 MarcosMang. All rights reserved.
//

import Foundation
import UIKit
extension UIAlertController {
    static func makeReconfirmAlert(title: String, confirm: String = "Confirm", confirmAction: (() -> Void)? = nil, cancel: String? = nil, cancelAction: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancel, style: .cancel) { action in
            cancelAction?()
            alert.dismiss(animated: true, completion: nil)
        }
        let confirmAction = UIAlertAction(title: confirm, style: .destructive) { action in
            confirmAction?()
        }
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        return alert
    }
}

extension UIViewController {
    /// Replace childController of Root
      ///
      /// - Parameters:
      ///   - fvc: from Controller
    ///   - tvc: to Controller
    func replace(from fvc: UIViewController, to tvc: UIViewController) {
        if fvc == tvc { return }
        addChild(tvc)
        tvc.view.alpha = 0
        view.addSubview(tvc.view)
        tvc.view.alpha = 1
        tvc.didMove(toParent: self)
        removeChild(fvc)
    }

    func removeChild(_ vc: UIViewController) {
        if let idx = children.firstIndex(of: vc) {
            removeChildAt(idx)
            return
        }
        print("no such child viewcontroller")
    }

    private func removeChildAt(_ idx: Int) {
        for (index, vc) in children.enumerated() where index == idx {
            vc.didMove(toParent: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParent()
            return
        }
        print("no such child controller at idx")
    }
}

extension UIViewController {
    /// 获取当前显示的控制器 UIWindow (Visible)
    public class func getCurrentController() -> UIViewController? {
        if let keywindow = UIApplication.shared.keyWindow?.rootViewController {
            return getVisibleViewControllerFrom(vc: keywindow)
        }
        return nil
    }

   
    class func getVisibleViewControllerFrom(vc: UIViewController) -> UIViewController {
        if vc.isKind(of: UINavigationController.self) {
            return getVisibleViewControllerFrom(vc: (vc as! UINavigationController).visibleViewController!)
        } else if vc.isKind(of: UITabBarController.self) {
            return getVisibleViewControllerFrom(vc: (vc as! UITabBarController).selectedViewController!)
        }
//        else if vc.isKind(of: CusTabbarController.self) {
//            return getVisibleViewControllerFrom(vc: (vc as! CusTabbarController).currentController!)
//        }
        else {
            if vc.presentedViewController != nil {
                return getVisibleViewControllerFrom(vc: vc.presentedViewController!)
            } else {
                return vc
            }
        }
    }
}
