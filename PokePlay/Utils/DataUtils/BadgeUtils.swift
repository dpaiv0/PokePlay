//
//  MedalUtils.swift
//  PokePlay
//
//  Created by David Paiva on 26/06/2023.
//

import Foundation

struct BadgeUtils {
    static func GetBadgesFromUserDefaults() -> [Badge] {
        var badges: [Badge] = []
        
        if let data = UserDefaults.standard.data(forKey: "medals") {
            do {
                badges = try JSONDecoder().decode([Badge].self, from: data)
            } catch {
                print("Error decoding medals from UserDefaults: \(error)")
            }
        }
        
        return badges
    }
    
    static func SaveBadgesToUserDefaults(badges: [Badge]) {
        do {
            let data = try JSONEncoder().encode(badges)
            UserDefaults.standard.set(data, forKey: "medals")
        } catch {
            print("Error encoding medals to UserDefaults: \(error)")
        }
    }
    
    static func AddBadge(badge: Badge) {
        var badges = GetBadgesFromUserDefaults()
        badges.append(badge)
        SaveBadgesToUserDefaults(badges: badges)
    }
    
    static func RemoveBadge(badge: Badge) {
        var badges = GetBadgesFromUserDefaults()
        badges.removeAll(where: { $0.name == badge.name })
        SaveBadgesToUserDefaults(badges: badges)
    }
    
    static func HasBadge(badge: Badge) -> Bool {
        let badges = GetBadgesFromUserDefaults()
        return badges.contains(where: { $0.name == badge.name })
    }
}
