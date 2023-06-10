//
//  PokeUtils.swift
//  PokePlay
//
//  Created by David Paiva on 08/06/2023.
//

import Foundation

struct PokeUtils {
    static let path = Bundle.main.path(forResource: "PokemonStaticData", ofType: "plist")
    static let dict = NSDictionary(contentsOfFile: path ?? "")?.object(forKey: "Pokemon") as? [String: Any] ?? [:]
    
    // Pokémon Data
    
    static let pokemonDict = dict["pokemon"] as? [[String: Any]] ?? []
    static let pokemonData = try? JSONSerialization.data(withJSONObject: pokemonDict, options: [])
    
    static func GetPokemonById(id: Int) -> Pokemon {
        let pokemon = try? JSONDecoder().decode([Pokemon].self, from: pokemonData!)
        
        if let matchingPokemon = pokemon?.first(where: { $0.id == id }) {
            return matchingPokemon
        } else {
            fatalError("Pokémon not found for the given ID \(id).")
        }
    }
    
    static func GetPokemonByName(name: String) -> Pokemon {
        let pokemon = try? JSONDecoder().decode([Pokemon].self, from: pokemonData!)
        
        if let matchingPokemon = pokemon?.first(where: { $0.name == name.lowercased() }) {
            return matchingPokemon
        } else {
            fatalError("Pokémon not found for the given name.")
        }
    }
    
    static func GetColorForPokemonType(pokemon: Pokemon) -> String {
        let type = pokemon.types[0].type.name
        switch type {
        case "normal":
            return "#A8A878"
        case "fire":
            return "#F08030"
        case "fighting":
            return "#C03028"
        case "water":
            return "#6890F0"
        case "flying":
            return "#A890F0"
        case "grass":
            return "#78C850"
        case "poison":
            return "#A040A0"
        case "electric":
            return "#F8D030"
        case "ground":
            return "#E0C068"
        case "psychic":
            return "#F85888"
        case "rock":
            return "#B8A038"
        case "ice":
            return "#98D8D8"
        case "bug":
            return "#A8B820"
        case "dragon":
            return "#7038F8"
        case "ghost":
            return "#705898"
        case "dark":
            return "#705848"
        case "steel":
            return "#B8B8D0"
        case "fairy":
            return "#EE99AC"
        default:
            return "#FFFFFF"
        }
    }
    
    static func GetFrontPokemonSprite(id: Int) -> URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png") ?? nil
    }
    
    static func GetBackPokemonSprite(id: Int) -> URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/\(id).png") ?? nil
    }
    
    // Evolution Chain Data
    
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
            return GetPokemonByName(name: nextEvolution.name)
        } else {
            return nil
        }
    }
    
    // Pokédex Data
    
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
    
    // Pokémon Team Data
    
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
        
        if pokemonTeam.pokemonList.contains(where: { $0.id == pokemon.id }) {
            return
        }
        
        var newPokemonTeam = pokemonTeam
        newPokemonTeam.pokemonList.append(pokemon)
        
        SavePokemonTeamToUserDefaults(pokemonTeam: newPokemonTeam)
    }
    
    static func RemovePokemonFromTeam(pokemon: ComplexPokemon) {
        let pokemonTeam = GetPokemonTeamFromUserDefaults()
        
        if !pokemonTeam.pokemonList.contains(where: { $0.id == pokemon.id }) {
            return
        }
        
        var newPokemonTeam = pokemonTeam
        newPokemonTeam.pokemonList.removeAll(where: { $0.id == pokemon.id })
        
        SavePokemonTeamToUserDefaults(pokemonTeam: newPokemonTeam)
    }
    
    static func GetPokemonTeamCount() -> Int {
        let pokemonTeam = GetPokemonTeamFromUserDefaults()
        return pokemonTeam.pokemonList.count
    }
}
