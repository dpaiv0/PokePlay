//
//  PokedexDataUtils.swift
//  PokePlay
//
//  Created by David Paiva on 13/06/2023.
//

import Foundation

struct PokedexDataUtils {
    static func GetPokedexFromUserDefaults() -> Pokedex {
        let defaults = UserDefaults.standard
        let pokedexData = defaults.object(forKey: "pokedex") as? Data ?? Data()
        
        if let pokedex = try? JSONDecoder().decode(Pokedex.self, from: pokedexData) {
            return pokedex
        } else {
            return Pokedex(pokemonList: [])
        }
    }
    
    static func SavePokedexToUserDefaults(pokedex: Pokedex) {
        let defaults = UserDefaults.standard
        let pokedexData = try? JSONEncoder().encode(pokedex)
        defaults.set(pokedexData, forKey: "pokedex")
    }
    
    static func AppendPokemonToPokedex(pokemon: Pokemon) {
        let pokedex = GetPokedexFromUserDefaults()
        
        if pokedex.pokemonList.contains(where: { $0.id == pokemon.id }) {
            return
        }
        
        var newPokedex = pokedex
        newPokedex.pokemonList.append(pokemon)
        
        SavePokedexToUserDefaults(pokedex: newPokedex)
    }
}
