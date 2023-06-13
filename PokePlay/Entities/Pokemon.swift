//
//  Pokemon.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    var stats: [Stat]
    var moves: [Move]
    var types: [PokemonType]
}
