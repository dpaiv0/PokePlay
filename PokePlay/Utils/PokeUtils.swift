//
//  PokeUtils.swift
//  PokePlay
//
//  Created by David Paiva on 08/06/2023.
//

import Foundation

struct PokeUtils {
    static let path = Bundle.main.path(forResource: "PokemonStaticData", ofType: "plist")
    static let _dict = NSDictionary(contentsOfFile: path ?? "")?.object(forKey: "Pokemon") as? [String: Any] ?? [:]
    static let dict = _dict["pokemon"] as? [[String: Any]] ?? []
    static let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
    
    static func GetPokemonById(id: Int) -> Pokemon {
        let pokemon = try? JSONDecoder().decode([Pokemon].self, from: data!)
        
        if let matchingPokemon = pokemon?.first(where: { $0.id == id }) {
            return matchingPokemon
        } else {
            fatalError("Pokémon not found for the given ID.")
        }
    }
    
    static func GetPokemonByName(name: String) -> Pokemon {
        let pokemon = try? JSONDecoder().decode([Pokemon].self, from: data!)
        
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
    
    static func GetPokemonImage(id: Int) -> URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png") ?? nil
    }
}
