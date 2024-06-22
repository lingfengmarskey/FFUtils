//
//  KeyboardAssistant.swift
//  FFUtils
//
//  Created by MarcosMeng on R 2/07/09.
//

import Foundation
import UIKit
/// Keyboard Assistant
/// Get keyboard's rect on its windonw
public class KeyboardAssistant: NSObject {
    // MARK: - Public Properties
    public static let `default` = KeyboardAssistant()
    
    // MARK: - Private Properties
    private var fromView: UIView?

    // MARK: - Callback
    private var callBackRect: ((CGRect, Double) -> Void)?

    private var callBackCover: ((CGFloat, Double) -> Void)?
    
    // MARK: - Private
    private override init() {
        super.init()
        configObseve()
    }

    private func configObseve() {
        NotificationCenter.default.addObserver(self, selector: #selector(onObserve), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc private func onObserve(noti: Notification) {
        guard let keyboardValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let durationValue = noti.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let duration = durationValue.doubleValue
        callBackRect?(keyboardScreenEndFrame, duration)
        configCover(rect: keyboardScreenEndFrame, duration: duration)
    }

    private func configCover(rect: CGRect, duration: Double) {
        guard let view = fromView else { return }
        if let result = view.findFirstResponderTextField(),
           let superview = result.superview {
            let newRect = view.getConvertedFrame(textField: superview)

            let newOriginY = newRect.origin.y + newRect.size.height
            let oldRect = view.convert(rect, from: nil)
            let keyboardY = oldRect.origin.y
            let deeper = newOriginY - keyboardY
            if deeper > 0 {
                callBackCover?(deeper, duration)
            } else {
                callBackCover?(0, duration)
            }
        }
    }

    // MARK: - Public
    
    /// Keyboard Changed Rect and timing duration
    /// - Parameter callback: keyboard rect
    public func keyboardHeight(callback: @escaping (CGRect, Double) -> Void) {
        callBackRect = callback
    }
    
    /// Keyboard covered view deep lenght
    /// - Parameters:
    ///   - view: most toppest view
    ///   - callback: deeper callback, 0 is not covered.
    public func keyboardCoveredHeight(from view: UIView, callback: @escaping (CGFloat, Double) -> Void) {
        fromView = view
        callBackCover = callback
    }
}

extension UIView {
    func getAllTextFields() -> [UITextField]? {
        return subviews.compactMap { (view) -> [UITextField]? in
                if view is UITextField {
                    return [(view as! UITextField)]
                } else {
                    return view.getAllTextFields()
                }
            }.flatMap({$0})
    }

    func findFirstResponderTextField() -> UITextField? {
        guard let textFields = getAllTextFields() else {return nil}
        let result = textFields.first { (textField) -> Bool in
            textField.isFirstResponder
        }
        return result
    }
    
    func getConvertedFrame(textField: UIView) -> CGRect {
        let result = textField.convert(textField.frame, to: self)
        return result
    }
}
