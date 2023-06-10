//
//  PokemonTeam.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import Foundation

struct PokemonTeam : Codable {
    var pokemonList: [ComplexPokemon]
}

struct ComplexPokemon : Codable {
    var id: Int
    var hp: Int = 68
    var level: Int = 1
    var xp: Int = 0 // Level up when this reaches 20
    
    init(id: Int) {
        self.id = id
    }
}
