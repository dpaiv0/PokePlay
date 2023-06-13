//
//  EvolutionChainDataUtils.swift
//  PokePlay
//
//  Created by David Paiva on 13/06/2023.
//

import Foundation

struct EvolutionChainDataUtils {
    static let path = Bundle.main.path(forResource: "PokemonStaticData", ofType: "plist")
    static let dict = NSDictionary(contentsOfFile: path ?? "")?.object(forKey: "Pokemon") as? [String: Any] ?? [:]
    
    static let evolutionChainDict = dict["chains"] as? [[String: Any]] ?? []
    static let evolutionChainData = try? JSONSerialization.data(withJSONObject: evolutionChainDict, options: [])
    
    static func GetEvolutionChainByPokemon(pokemon: Pokemon) -> EvolutionChain {
        let evolutionChain = try? JSONDecoder().decode([EvolutionChain].self, from: evolutionChainData!)
        
        if let matchingEvolutionChain = evolutionChain?.first(where: {
            $0.species.contains(where: {
                $0.id == pokemon.id
            })
        }) {
            return matchingEvolutionChain
        } else {
            fatalError("Evolution chain not found for the given Pokémon.")
        }
    }
    
    static func GetNextEvolutionByPokemon(pokemon: Pokemon) -> Pokemon? {
        let evolutionChain = GetEvolutionChainByPokemon(pokemon: pokemon)
        
        // Get pokémon that's after the current one in the evolution chain
        if let nextEvolution = evolutionChain.species.first(
            where: {
                $0.id == pokemon.id + 1
            }
        ) {
            return PokemonDataUtils.GetPokemonByName(name: nextEvolution.name)
        } else {
            return nil
        }
    }
}
