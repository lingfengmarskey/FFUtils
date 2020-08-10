//
//  Extension+UIAlertController.swift
//  FFUtils
//
//  Created by MarcosMang on R 2/08/11.
//

import Foundation
import UIKit
public extension UIAlertController {
    static func makeReconfirmAlert(title: String, confirm: String = "Confirm", confirmAction: (() -> Void)? = nil, cancel: String? = nil, cancelAction: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancel, style: .cancel) { action in
            cancelAction?()
            alert.dismiss(animated: true, completion: nil)
        }
        let confirmAction = UIAlertAction(title: confirm, style: .destructive) { action in
            confirmAction?()
        }
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        return alert
    }
}
