//
//  Extension.swift
//  HabitsKeeper
//
//  Created by Marcos Meng on 2020/1/6.
//  Copyright © 2024 MarcosMeng. All rights reserved.
//

import Foundation

public extension Date {
    static func currentTime() -> TimeInterval {
        Date().timeIntervalSince1970
    }

    static let oneDay: TimeInterval = (24 * oneHour)

    static let oneWeek: TimeInterval = (7 * oneDay)

    static let oneHour: TimeInterval = (60 * oneMinite)

    static let oneMinite: TimeInterval = 60

    // Compare two time if is in the same day,
    // In the same time zone on your device.
    func isSameDay(compare: Date = Date()) -> Bool {
        let canlendar = Calendar.current
        let result = canlendar.compare(self, to: compare, toGranularity: .day)
        return result == .orderedSame
    }

    func isYestoday(compare: Date = Date(timeIntervalSinceNow: -Date.oneDay)) -> Bool {
        let canlendar = Calendar.current
        let result = canlendar.compare(self, to: compare, toGranularity: .day)
        return result == .orderedSame
    }
}
