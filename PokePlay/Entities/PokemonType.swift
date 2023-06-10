//
//  PokemonType.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import Foundation

struct PokemonType: Codable {
    let type: TypeDetail
}

struct TypeDetail: Codable {
    let name: String
}
