//
//  Bag.swift
//  PokePlay
//
//  Created by David Paiva on 25/06/2023.
//

import Foundation

struct Item {
    var name: String
    var description: String
    var sprite: String
    
    init(name: String, description: String, sprite: String) {
        self.name = name
        self.description = description
        self.sprite = sprite
    }
}

struct Bag {
    static func GetBag() -> [Item] {
        let pokeball = Item(name: "Pokeball", description: "A device for catching wild Pokemon.", sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/poke-ball.png")
        let potion = Item(name: "Potion", description: "A spray-type medicine for treating wounds.", sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/potion.png")
        
        return [pokeball, potion]
    }
}
