//
//  DataManager.swift
//  HabitsKeeper
//
//  Created by fenrir Marcos Meng on 2019/12/30.
//  Copyright © 2019 Marskey. All rights reserved.
//

import Foundation
import RealmSwift

let currentSchemeVersion: UInt64 = 1
let realmName = "HabitsKeeper.realm"
struct DataManager {
    static let `default` = DataManager()

    private init() {
        configDefaults()
    }

    func currentRealm() -> Realm {
        let realm = try! Realm()
        return realm
    }

    private func configDefaults() {
        var config = Realm.Configuration.defaultConfiguration
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent(realmName)
        Realm.Configuration.defaultConfiguration = config

        initlizeLocalData()

        if let path = Realm.Configuration.defaultConfiguration.fileURL {
            print("realm db local path:\(path)")
        }
    }

    private func initlizeLocalData() {
        //        if let _ = get(id: homeID, cls: HomeList.self) as? HomeList {
        //            return
        //        }
        //        write { (realm) in
        //            let d = HomeList()
        //            realm.add(d)
        //        }
    }

    // MARK: Public Method

    public static func migrationConfig() {
        let config = Realm.Configuration(
            schemaVersion: currentSchemeVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
//                     migration.enumerateObjects(ofType: HomeList.className()) { oldObject, newObject in
//                         if oldSchemaVersion < currentSchemeVersion {
//                             let firstName = oldObject!["title"] as! String
//                             newObject?["subTitle"] = "\(firstName)"
//                         }
//
//                     }
                }
                if oldSchemaVersion < currentSchemeVersion {
//                     migration.enumerateObjects(ofType: HomeList.className()) { oldObject, newObject in
//                         if oldSchemaVersion < currentSchemeVersion {
//                             // combine name fields into a single field
//                             let firstName = oldObject!["subTitle"] as! String
//                             newObject?["largeString"] = "\(firstName)"
//                         }
//
//                     }
                }
            }
        )

        Realm.Configuration.defaultConfiguration = config
    }

    public func write(action: (Realm) -> Void) {
        let realm = currentRealm()
        do {
            try realm.write {
                action(realm)
            }
        } catch {
            print("write error:\(error)")
        }
    }

    public func get(id: String, cls: Object.Type) -> Object? {
        let realm = currentRealm()
        let obj = realm.object(ofType: cls, forPrimaryKey: id)
        return obj
    }
}
