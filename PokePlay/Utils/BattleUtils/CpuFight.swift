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
    
    static func GetRandomPokemonTeamByType(type: String) -> [Pokemon] {
        var team: [Pokemon] = []
        
        for _ in 1...6 {
            let pokemon = GetRandomPokemonByType(type: type)
            team.append(pokemon)
        }
        
        return team
    }
    
    private static func GetRandomPokemonByType(type: String) -> Pokemon {
        let randomInt = Int.random(in: 1..<152)
        let pokemon = PokemonDataUtils.GetPokemonById(id: randomInt)
        
        if pokemon.types.contains(where: { $0.type.name == type }) {
            return pokemon
        } else {
            return GetRandomPokemonByType(type: type)
        }
    }
}
