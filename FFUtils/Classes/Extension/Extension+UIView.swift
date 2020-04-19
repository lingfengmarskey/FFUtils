//
//  Extension+UIView.swift
//  HabitsKeeper
//
//  Created by fenrir Marcos Meng on 2019/12/25.
//  Copyright © 2019 MarcosMang. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    static var clasName: String {
        String(describing: self)
    }

    static var nib: UINib {
        let n = clasName
        return UINib(nibName: n, bundle: .main)
    }

    func loadNib() {
        let cls = type(of: self)
        Bundle.main.loadNibNamed(cls.clasName, owner: self, options: nil)
        let v = cls.nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(v)
        v.frame = bounds
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    var height: CGFloat {
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            frame.size.height
        }
    }

    var width: CGFloat {
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
            frame.size.width
        }
    }

    var x: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }

        get {
            frame.origin.x
        }
    }

    var y: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }

        get {
            frame.origin.y
        }
    }

    var bottom: CGFloat {
        set {
            let originY = newValue - height
            y = originY
        }
        get {
            frame.origin.y + height
        }
    }

    var center_y: CGFloat {
        set {
            var ct = center
            ct.y = newValue
            center = ct
        }
        get {
            center.y
        }
    }

    var center_x: CGFloat {
        set {
            var ct = center
            ct.x = newValue
            center = ct
        }
        get {
            center.x
        }
    }
}
