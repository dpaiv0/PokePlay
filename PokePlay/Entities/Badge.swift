//
//  Badge.swift
//  PokePlay
//
//  Created by David Paiva on 26/06/2023.
//

import Foundation

struct Badge : Codable {
    var name: String
    var sprite: String

    init(name: String, sprite: String) {
        self.name = name
        self.sprite = sprite
    }
    
    func GetSprite() -> URL {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/badges/\(self.sprite).png")!
    }
    
}
