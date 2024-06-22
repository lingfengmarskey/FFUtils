//
//  NotificationMaker.swift
//  FFUtils
//
//  Created by MarcosMeng on 2021/5/3.
//  Copyright © 2024 MarcosMeng. All rights reserved.
//

import Foundation
import NotificationCenter

public final class NotificationMaker: NSObject {
    public static let `default` = NotificationMaker()

    private override init() {
        super.init()
    }

    // MARK: Public Method

    public func requestAuth() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound, .carPlay]) { isSuc, error in
            print("isSuccess:\(isSuc)")
            if let error = error {
                print("error:\(error)")
            }
            UNUserNotificationCenter.current().delegate = self
        }
    }

    public func makeNotiRequest(title: String, contentString: String, identifier: String, after: TimeInterval) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: after, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = contentString

        content.sound = .default
        content.threadIdentifier = "mark-alert"
//        content.summaryArgumentCount = 1
//        content.summaryArgument = ""
        let req = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(req) { error in
            if let error = error {
                print("error:\(error)")
            }
        }
    }

    public func removeNoti(_ identifier: String) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { request in
            let res = request.filter { (req) -> Bool in
                req.identifier == identifier
            }.map { (req) -> String in
                req.identifier
            }
            print("waiting to be removed notis:\(res)")
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: res)
        }
    }
}

extension NotificationMaker: UNUserNotificationCenterDelegate {
    // foreceground will present noti banner
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }

    // tap notification banner
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("-----")
    }

    public func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {}
}
