//
//  PokemonTeamDataUtils.swift
//  PokePlay
//
//  Created by David Paiva on 13/06/2023.
//

import Foundation

struct PokemonTeamDataUtils {
    static func GetPokemonTeamFromUserDefaults() -> PokemonTeam {
        let defaults = UserDefaults.standard
        let pokemonTeamData = defaults.object(forKey: "pokemonTeam") as? Data ?? Data()
        
        if let pokemonTeam = try? JSONDecoder().decode(PokemonTeam.self, from: pokemonTeamData) {
            return pokemonTeam
        } else {
            return PokemonTeam(pokemonList: [])
        }
    }
    
    static func SavePokemonTeamToUserDefaults(pokemonTeam: PokemonTeam) {
        let defaults = UserDefaults.standard
        let pokemonTeamData = try? JSONEncoder().encode(pokemonTeam)
        defaults.set(pokemonTeamData, forKey: "pokemonTeam")
    }
    
    static func AppendPokemonToTeam(pokemon: ComplexPokemon) {
        let pokemonTeam = GetPokemonTeamFromUserDefaults()
        
        if pokemonTeam.pokemonList.contains(where: { $0.pokemon.id == pokemon.pokemon.id }) {
            return
        }
        
        var newPokemonTeam = pokemonTeam
        newPokemonTeam.pokemonList.append(pokemon)
        
        SavePokemonTeamToUserDefaults(pokemonTeam: newPokemonTeam)
    }
    
    static func RemovePokemonFromTeam(pokemon: ComplexPokemon) -> PokemonTeam {
        let pokemonTeam = GetPokemonTeamFromUserDefaults()
        
        if !pokemonTeam.pokemonList.contains(where: { $0.pokemon.id == pokemon.pokemon.id }) || pokemonTeam.pokemonList.count == 1 {
            return pokemonTeam
        }
        
        var newPokemonTeam = pokemonTeam
        newPokemonTeam.pokemonList.removeAll(where: { $0.pokemon.id == pokemon.pokemon.id })
        
        if (newPokemonTeam.favoritePokemon?.pokemon.id == pokemon.pokemon.id) {
            newPokemonTeam.favoritePokemon = nil
        }
        
        SavePokemonTeamToUserDefaults(pokemonTeam: newPokemonTeam)
        
        return newPokemonTeam
    }
    
    static func GetPokemonTeamCount() -> Int {
        let pokemonTeam = GetPokemonTeamFromUserDefaults()
        return pokemonTeam.pokemonList.count
    }
    
    static func SetFavoritePokemon(pokemon: ComplexPokemon) -> PokemonTeam {
        let pokemonTeam = GetPokemonTeamFromUserDefaults()
        
        if !pokemonTeam.pokemonList.contains(where: { $0.pokemon.id == pokemon.pokemon.id }) {
            return pokemonTeam
        }
        
        var newPokemonTeam = pokemonTeam
        newPokemonTeam.favoritePokemon = pokemon.isFavorite() ? nil : pokemon
        
        SavePokemonTeamToUserDefaults(pokemonTeam: newPokemonTeam)
        
        return newPokemonTeam
    }
    
    static func GetFavoritePokemon() -> ComplexPokemon? {
        let pokemonTeam = GetPokemonTeamFromUserDefaults()
        return pokemonTeam.favoritePokemon
    }
    
    static func GetFavoriteOrFirstPokemon() -> ComplexPokemon {
        let pokemonTeam = GetPokemonTeamFromUserDefaults()
        
        if let favoritePokemon = pokemonTeam.favoritePokemon {
            return favoritePokemon
        }
        
        return pokemonTeam.pokemonList[0]
    }
    
    static func UpdatePokemonFromTeam(pokemon: ComplexPokemon) -> PokemonTeam {
        let pokemonTeam = GetPokemonTeamFromUserDefaults()
        
        if !pokemonTeam.pokemonList.contains(where: { $0.pokemon.id == pokemon.pokemon.id }) {
            return pokemonTeam
        }
        
        var newPokemonTeam = pokemonTeam
        newPokemonTeam.pokemonList.removeAll(where: { $0.pokemon.id == pokemon.pokemon.id })
        newPokemonTeam.pokemonList.append(pokemon)
        
        if (newPokemonTeam.favoritePokemon?.pokemon.id == pokemon.pokemon.id) {
            newPokemonTeam.favoritePokemon = pokemon
        }
        
        SavePokemonTeamToUserDefaults(pokemonTeam: newPokemonTeam)
        
        return newPokemonTeam
    }
    
    static func HealPokemonTeam() -> PokemonTeam {
        let pokemonTeam = GetPokemonTeamFromUserDefaults()
        
        var newPokemonTeam = pokemonTeam
        
        for (index, pokemon) in newPokemonTeam.pokemonList.enumerated() {
            newPokemonTeam.pokemonList[index].currentHealth = Double(pokemon.getBaseHp())
        }
        
        if (newPokemonTeam.favoritePokemon != nil) {
            newPokemonTeam.favoritePokemon!.currentHealth = Double(newPokemonTeam.favoritePokemon!.getBaseHp())
        }
        
        SavePokemonTeamToUserDefaults(pokemonTeam: newPokemonTeam)
        
        return newPokemonTeam
    }
    
    static func AllPokemonsFainted() -> Bool {
        let pokemonTeam = GetPokemonTeamFromUserDefaults()
        
        for pokemon in pokemonTeam.pokemonList {
            if pokemon.currentHealth > 0 {
                return false
            }
        }
        
        return true
    }
    
    static func GetFirstNotFaintedPokemon() -> ComplexPokemon? {
        let pokemonTeam = GetPokemonTeamFromUserDefaults()
        
        for pokemon in pokemonTeam.pokemonList {
            if pokemon.currentHealth > 0 {
                return pokemon
            }
        }
        
        return nil
    }
    
}
