//
//  CpuFight.swift
//  PokePlay
//
//  Created by David Paiva on 17/06/2023.
//

import Foundation

struct CpuFight {
    // Wilderness battles
    static func GetRandomPokemon() -> Pokemon {
        let randomInt = Int.random(in: 1..<152)
        
        return PokemonDataUtils.GetPokemonById(id: randomInt)
    }
    
    // Gym battles
    static func GetRandomPokemonTeam() -> [Pokemon] {
        var team: [Pokemon] = []
        
        for _ in 1...6 {
            let randomInt = Int.random(in: 1..<152)
            
            team.append(PokemonDataUtils.GetPokemonById(id: randomInt))
        }
        
        return team
    }
}
