//
//  Gym.swift
//  PokePlay
//
//  Created by David Paiva on 26/06/2023.
//

import Foundation

struct Gym {
    var name: String
    var sprite: String
    var badge: Badge
    var type: String
    var gymLeader: Trainer
    
    init(name: String, sprite: String, badge: Badge, type: String, gymLeader: Trainer) {
        self.name = name
        self.sprite = sprite
        self.badge = badge
        self.type = type
        self.gymLeader = gymLeader
    }
}
