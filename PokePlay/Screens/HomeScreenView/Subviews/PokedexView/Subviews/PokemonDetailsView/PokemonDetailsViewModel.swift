//
//  PokemonDetailsViewModel.swift
//  PokePlay
//
//  Created by David Paiva on 05/07/2023.
//

import Foundation

final class PokemonDetailsViewModel : ObservableObject {
    @Published var pokemon: Pokemon = PokeUtils.PokemonData.GetPokemonById(id: 1)
    
    func GetId(_ id: Int) -> String {
        if (1...9).contains(id) {
            return "00\(id)"
        } else if (10...99).contains(id) {
            return "0\(id)"
        } else {
            return "\(id)"
        }
    }
}
