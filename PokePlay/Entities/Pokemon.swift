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
    let stats: [Stat]
    let moves: [Move]
    let types: [PokemonType]
}
