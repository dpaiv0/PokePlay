//
//  Trainer.swift
//  PokePlay
//
//  Created by David Paiva on 26/06/2023.
//

import Foundation

struct Trainer {
    var name: String
    var sprite: String
    var team: [ComplexPokemon]
    
    init(name: String, sprite: String, team: [ComplexPokemon]) {
        self.name = name
        self.sprite = sprite
        self.team = team
    }
    
    func GetSprite() -> URL {
        return URL(string: "https://img.pokemondb.net/sprites/trainers/red-blue/\(self.sprite).png")!
    }
}
