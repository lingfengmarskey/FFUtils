//
//  Extension+UITableView.swift
//  HabitsKeeper
//
//  Created by Marcos Meng on 2019/12/25.
//  Copyright © 2014 MarcosMeng. All rights reserved.
//

import Foundation
import UIKit
public extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = String(describing: cellType)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
}

public extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = String(describing: cellType)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func registerNibCell(nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: nibName)
    }
}

public extension UITableView {
    func dequeueReusableCellIfNeededRegist(reuseIdentifier: String) -> UITableViewCell {
        if let cell = dequeueReusableCell(withIdentifier: reuseIdentifier) {
            return cell
        }
        registerNibCell(nibName: reuseIdentifier)
        if let cell = dequeueReusableCell(withIdentifier: reuseIdentifier) {
            return cell
        }
        return UITableViewCell()
    }

    func registerNibCell(nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: nibName)
    }
}
