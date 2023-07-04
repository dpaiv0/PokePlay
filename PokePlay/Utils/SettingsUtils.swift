//
//  SettingsUtils.swift
//  PokePlay
//
//  Created by David Paiva on 30/06/2023.
//

import Foundation

struct SettingsUtils {
    static var Defaults = UserDefaults.standard
    
    static func GetSetting(key: String) -> Any? {
        return Defaults.object(forKey: key)
    }
    
    static func SetSetting(key: String, value: Any) {
        Defaults.set(value, forKey: key)
    }
    
    static func ClearData() {
        if let bundleID = Bundle.main.bundleIdentifier {
            Defaults.removePersistentDomain(forName: bundleID)
        }
        
        Defaults.set(true, forKey: "render_badges")
    }
}
