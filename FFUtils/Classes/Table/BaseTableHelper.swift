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

public class BaseTableHelper: NSObject {
    public var table: UITableView
    public var data: TableDataModel?

    public var didTapCell: ((IndexPath, TableDataModel?) -> Void)?

    // MARK: - Life method

    init(table: UITableView) {
        self.table = table
        super.init()
        setup()
    }

    open func configCommon() {}

    private func setup() {
        table.dataSource = self
        table.delegate = self
        configCommon()
    }

    public func configData(_ tableData: TableDataModel) {
        data = tableData
        table.reloadData()
    }
}

extension BaseTableHelper: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionModel = data?.section[safe: indexPath.section],
            let cellModel = sectionModel.cells[safe: indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCellIfNeededRegist(reuseIdentifier: cellModel.reuseIdentifier)
        cell.bindData(cellModel)
        return cell
    }

    public func numberOfSections(in _: UITableView) -> Int {
        data?.section.count ?? 0
    }

    public func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionModel = data?.section[safe: section] else { return 0 }
        return sectionModel.cells.count
    }
}

extension BaseTableHelper: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didTapCell?(indexPath, data)
    }
}
