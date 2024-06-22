//
//  Extension+Foundation.swift
//  HabitsKeeper
//
//  Created by Marcos Meng on 2020/1/7.
//  Copyright © 2024 MarcosMeng. All rights reserved.
//

import Foundation
import UIKit

public extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

public extension Array {
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

public extension CGFloat {
    static var onePixelWidth: CGFloat {
        1 / UIScreen.main.scale
    }

    static var onePixelOffset: CGFloat {
        1 / UIScreen.main.scale / 2
    }

    var onePixelValue: CGFloat {
        return self - .onePixelOffset
    }

    var intValue: Int {
        return Int(self)
    }
}

public extension Int {
    var cgfloatValue: CGFloat {
        return CGFloat(self)
    }

    var doubleValue: Double {
        return Double(self)
    }
}
