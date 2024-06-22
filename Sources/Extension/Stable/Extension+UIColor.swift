//
//  Extension+UIColor.swift
//  HabitsKeeper
//
//  Created by MarcosMeng on 24/12/2019.
//  Copyright © 2014 MarcosMeng. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }

    class func randomColor() -> UIColor {
        let red: Int = Int.random(in: 0 ... 255)
        let green: Int = Int.random(in: 0 ... 255)
        let blue: Int = Int.random(in: 0 ... 255)
        let result = UIColor(red: red, green: green, blue: blue)
        return result
    }
}
