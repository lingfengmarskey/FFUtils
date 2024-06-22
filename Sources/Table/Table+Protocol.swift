//
//  Helper.swift
//  HabitsKeeper
//
//  Created by Marcos Meng on 2019/12/27.
//  Copyright © 2014 MarcosMeng. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Table data

public protocol TableDataModel {
    var section: [SectionModel] { get }
    func getCellModel(indexPath: IndexPath) -> CellModel?
}

public extension TableDataModel {
    func getCellModel(indexPath: IndexPath) -> CellModel? {
        guard let sectionModel = section[safe: indexPath.section],
            let cellModel = sectionModel.cells[safe: indexPath.row]
        else { return nil }
        return cellModel
    }
}

public protocol SectionModel {
    var cells: [CellModel] { get }
}

public protocol CellModel {
    var reuseIdentifier: String { get }
}

public protocol TableCellDataProtocol {
    func bindData(_ data: Any)
}

extension UITableViewCell: TableCellDataProtocol {
    @objc open func bindData(_: Any) {}
}

extension UICollectionViewCell: TableCellDataProtocol {
    @objc open func bindData(_ data: Any) {}
}
