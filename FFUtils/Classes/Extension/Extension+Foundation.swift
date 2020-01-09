//
//  Extension+Foundation.swift
//  HabitsKeeper
//
//  Created by fenrir Marcos Meng on 2020/1/7.
//  Copyright © 2020 MarcosMang. All rights reserved.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension Array {
    func subsequence(from: Int, to: Int) -> [Array.Element]? {
        if from > count - 1 || from < 0 { return nil }
        if from >= to { return nil }
        let end = to >= count ? count : to
        var result: [Array.Element] = []
        for tup in from ..< end {
            if let d = self[safe: tup] {
                result.append(d)
            }
        }
        return result
    }
}
