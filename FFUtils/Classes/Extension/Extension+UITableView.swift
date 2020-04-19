//
//  Extension+UITableView.swift
//  HabitsKeeper
//
//  Created by fenrir Marcos Meng on 2019/12/25.
//  Copyright © 2019 MarcosMang. All rights reserved.
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

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = String(describing: cellType)
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }
}
