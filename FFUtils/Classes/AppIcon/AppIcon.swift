//
//  AppIcon.swift
//  FFUtils
//
//  Created by MarcosMang on R 2/08/11.
//

import Foundation

@available(iOSApplicationExtension, unavailable)
struct AppIcon {
    /// 更新远程图标
    ///  具体是指远程需要本地显示的图标代号
    /// - Parameter icon: String Name
    public static func updateRemoteIcon(icon:String) -> Void {
        guard !icon.isEmpty else {
                        
            return
        }
        UserDefaults.standard.setValue(icon, forKey: "remoteIcon")
    }
    
    /// 更新本地icon存储
    ///
    /// - Parameter icon: iconName
    @available(iOSApplicationExtension, unavailable)
    public static func updateLocalIcon(icon:String) -> Void {
        guard #available(iOS 10.3, *) else { return }
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }
        let localIcon = icon.isEmpty ? nil : icon
        UIApplication.shared.setAlternateIconName(localIcon) { (error) in
            if error != nil {
                print("----SetAlternateIconName_has_someting_is_wrong-----")
            }else{
                UserDefaults.standard.setValue(localIcon, forKey: "localIcon")
            }
        }
    }
    /// 动态更新图标 如果需要的话
    public static func updateDynamicIconIfNeeded() -> Void {
        guard #available(iOS 10.3,*) else {
            return
        }
        guard let remoteIcon = UserDefaults.standard.value(forKey: "remoteIcon") as? String else{
            return
        }
        if let localIcon = UserDefaults.standard.value(forKey: "localIcon") as? String , !localIcon.isEmpty{
            if localIcon != remoteIcon {
                // 更新本地图标
                updateLocalIcon(icon: remoteIcon)
            }
        }else{
            // 更新本地图标
            updateLocalIcon(icon: remoteIcon)
        }
    }
}
