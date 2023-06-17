//
//  CpuFight.swift
//  PokePlay
//
//  Created by David Paiva on 17/06/2023.
//

import Foundation

struct CpuFight {
    static func GetRandomPokemon() -> Pokemon {
        let randomInt = Int.random(in: 1..<152)
        
        return PokemonDataUtils.GetPokemonById(id: randomInt)
    }
}
