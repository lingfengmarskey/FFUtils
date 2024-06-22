//
//  Helper.swift
//  HabitsKeeper
//
//  Created by Marcos Meng on 2019/12/27.
//  Copyright © 2014 MarcosMeng. All rights reserved.
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
