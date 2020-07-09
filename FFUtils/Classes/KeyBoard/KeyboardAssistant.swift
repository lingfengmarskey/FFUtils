//
//  KeyboardAssistant.swift
//  FFUtils
//
//  Created by MarcosMang on R 2/07/09.
//

import Foundation
import UIKit
/// Keyboard Assistant
/// Get keyboard's rect on its windonw
public class KeyboardAssistant: NSObject {
    public static let `default` = KeyboardAssistant()
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
