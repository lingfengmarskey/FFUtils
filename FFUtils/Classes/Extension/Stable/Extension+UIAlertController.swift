//
//  Extension+UIAlertController.swift
//  FFUtils
//
//  Created by MarcosMang on R 2/08/11.
//

import Foundation
import UIKit
public extension UIAlertController {
    /// Make alert controller
    /// style that is only one title
    /// only on blue text button
    /// - Parameters:
    ///   - msg: message content
    ///   - okTitle: blue button title
    ///   - completion: callback on button click
    /// - Returns: specified style alert controller
    static func makeOkAlert(msg: String,
                            okTitle: String,
                            completion: (() -> Void)?) -> UIAlertController {
        let alertVc = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: okTitle,
                                          style: .default) { _ in
            completion?()
        }
        alertVc.addAction(confirmAction)
        return alertVc
    }

    typealias AlertCompletion = (Bool) -> Void

    /// Make a alert controller
    /// style that is destructive style button and
    /// a cancel styl button.
    /// - Parameters:
    ///   - title: alert title.
    ///   - msg: alert subtitle.
    ///   - leftCancelTitle: left cancel style button, bold blue text.
    ///   - rightDestructiveTitle: right destructive button, red text.
    ///   - completion: callback on button click, when ok button callback is true, the other is false
    /// - Returns: specified style alert controller
    static func makeDestructiveAlert(title: String,
                                     msg: String,
                                     leftCancelTitle: String,
                                     rightDestructiveTitle: String,
                                     completion: AlertCompletion?) -> UIAlertController {
        let alertVc = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: rightDestructiveTitle,
                                          style: .destructive) { _ in
            completion?(true)
        }
        alertVc.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: leftCancelTitle,
                                         style: .cancel) { _ in
            completion?(false)
        }
        alertVc.addAction(cancelAction)
        return alertVc
    }

    /// Make a alert controller
    /// style that is blue button text
    /// - Parameters:
    ///   - title: alert title
    ///   - msg: alert subtitle
    ///   - options: option button titles
    ///   - firstTitle: first button title
    ///   - completion: callback on button click
    /// - Returns: specified style alert controller
    static func makeAlert(title: String,
                          msg: String,
                          options: [String],
                          firstTitle: String,
                          completion: ((Int) -> Void)?) -> UIAlertController {
        let alertVc = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: firstTitle, style: .cancel) { _ in
            completion?(0)
        }
        alertVc.addAction(cancelAction)
        for (index, value) in options.enumerated() {
            let optionAction = UIAlertAction(title: value, style: .default) { _ in
                completion?(index + 1)
            }
            alertVc.addAction(optionAction)
        }
        return alertVc
    }

    /// Make a sheet alert controller
    /// - Parameters:
    ///   - title: title text
    ///   - message: subtitle text
    ///   - cancelTitle: cancel title
    ///   - options: sheet option titles
    ///   - completion: callback on sheet option click
    /// - Returns: sheet alert controller
    static func makeSheet(title: String,
                          message: String?,
                          cancelTitle: String,
                          options: [String],
                          completion: ((Int) -> Void)?) -> UIAlertController {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .actionSheet)
        for (index, value) in options.enumerated() {
            let optionAction = UIAlertAction(title: value, style: .default) { _ in
                completion?(index)
            }
            alertController.addAction(optionAction)
        }

        let cancelAction = UIAlertAction(title: cancelTitle,
                                         style: .cancel) { _ in
            completion?(options.count)
        }
        alertController.addAction(cancelAction)
        return alertController
    }

    /// Make a input alert controller
    /// - Parameters:
    ///   - title: title text
    ///   - message: subtitle text
    ///   - cancelTitle: cancel title text
    ///   - okTitle: ok title
    ///   - placeholder: input placeholder text
    ///   - completion: callback on ok button click, get input text.
    /// - Returns: Input alert controller.
    static func makeInputAlert(title: String,
                               message: String?,
                               cancelTitle: String,
                               okTitle: String,
                               placeholder: String? = nil,
                               completion: ((String) -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = placeholder
            textField.returnKeyType = .done
        }

        func getText() -> String {
            guard let text = alert.textFields?.first?.text else {
                return ""
            }
            return text
        }
        let cancelAction = UIAlertAction(title: cancelTitle,
                                         style: .cancel,
                                         handler: nil)
        let confirmAction = UIAlertAction(title: okTitle,
                                          style: .default) { _ in
            alert.resignFirstResponder()
            completion?(getText())
        }
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        return alert
    }
}
