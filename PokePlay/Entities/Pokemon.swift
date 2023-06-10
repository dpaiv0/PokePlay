//
//  Pokemon.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import Foundation

struct Pokemon: Codable {
    var id: Int
    var name: String
    var height: Int
    var weight: Int
    var stats: [Stat]
    var moves: [Move]
    var types: [PokemonType]
}
