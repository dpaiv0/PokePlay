//
//  EvolutionChain.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import Foundation

struct EvolutionChain : Codable {
    public var id: Int
    public var species: [Specie]
}

struct Specie : Codable {
    public var id: Int
    public var name: String
}

