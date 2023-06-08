//
//  PokeUtils.swift
//  PokePlay
//
//  Created by David Paiva on 08/06/2023.
//

import Foundation

struct PokeUtils {
    static let path = Bundle.main.path(forResource: "PokemonStaticData", ofType: "plist")
    static let dict = NSDictionary(contentsOfFile: path!)!.object(forKey: "Pokemon") as! [String: Any]
    static let pokemonList = dict["pokemon"] as! [Any]
    
    static func GetPokemonById(id: Int) -> Any {
        return pokemonList[id - 1]
    }
}
