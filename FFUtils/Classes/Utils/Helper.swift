//
//  Helper.swift
//  HabitsKeeper
//
//  Created by fenrir Marcos Meng on 2019/12/27.
//  Copyright © 2019 MarcosMang. All rights reserved.
//

import Foundation
import UIKit

/// Log Method
///
/// - Parameters:
///   - message: Customized Message
///   - file: fileName
///   - method: methodName
///   - line: code line Number
public func FFLog(_ message: String = "",
                  file: String = #file,
                  method: String = #function,
                  line: Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method)")
        if !message.isEmpty {
            print("\(message)")
        }
        print("\n")
    #endif
}

/// Keyboard Assistant
/// Get keyboard's rect on its windonw
class KeyboardAssistant: NSObject {
    static let `default` = KeyboardAssistant()
    private var callBackRect: ((CGRect, Double) -> Void)?
    private override init() {
        super.init()
        configObseve()
    }

    private func configObseve() {
        NotificationCenter.default.addObserver(self, selector: #selector(onObserve), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onObserve), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func onObserve(noti: Notification) {
        guard let keyboardValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let durationValue = noti.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let duration = durationValue.doubleValue
        callBackRect?(keyboardScreenEndFrame, duration)
    }

    public func keyboardHeight(callback: @escaping (CGRect, Double) -> Void) {
        callBackRect = callback
    }
}

/// TableView Helper
/// Handle Table's data source and delegate action
open class TableHelper: NSObject, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView
    var data: [Any] = []
    var cell: UITableViewCell.Type

    fileprivate var autoPullrefresh: Bool

    init(_ table: UITableView, arr list: [Any], cell cellType: UITableViewCell.Type, pullRefresh: Bool = false) {
        tableView = table
        data = list
        cell = cellType
        autoPullrefresh = pullRefresh
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
        table.register(cellType: cell)
        setup()
    }

    // MARK: Helpers

    private func setup() {
        tableView.rowHeight = UITableView.automaticDimension

        if #available(iOS 10.0, *), autoPullrefresh {
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        }
        configCostom()
    }

    public func configCostom() {}

    // MARK: - Private

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cl = tableView.dequeueReusableCell(withIdentifier: cell.clasName, for: indexPath)
        return cl
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    // MARK: Actions

    @objc func refreshHandler() {
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) { [weak self] in
            if #available(iOS 10.0, *) {
                self?.tableView.refreshControl?.endRefreshing()
            }
            self?.tableView.reloadData()
        }
    }
}
