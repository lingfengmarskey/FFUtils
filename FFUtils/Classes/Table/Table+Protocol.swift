//
//  Helper.swift
//  HabitsKeeper
//
//  Created by fenrir Marcos Meng on 2019/12/27.
//  Copyright © 2019 MarcosMang. All rights reserved.
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
    @objc public func bindData(_: Any) {
        print("---- bind data on table ----")
    }
}

extension UICollectionViewCell: TableCellDataProtocol {
    @objc public func bindData(_ data: Any) {
        print("---- bind data on collection ----")
    }
}
