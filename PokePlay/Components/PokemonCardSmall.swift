//
//  PokemonCardSmall.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonCardSmall: View {
    private var pokemon: Pokemon

    init(_ pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    func GetId() -> String {
        if (1...9).contains(pokemon.id) {
            return "00\(pokemon.id)"
        } else if (10...99).contains(pokemon.id) {
            return "0\(pokemon.id)"
        } else {
            return "\(pokemon.id)"
        }
    }
    
    func GetImageUrl() -> URL {
        // Check if the pokémon is on the user's Pokédex
        if PokeUtils.PokedexData.GetPokedexFromUserDefaults().pokemonList.firstIndex(where: { $0.id == pokemon.id }) != nil {
            return PokeUtils.PokemonData.GetFrontPokemonSprite(id: pokemon.id)!
        } else {
            return Bundle.main.url(forResource: "question-mark-pixelated\(colorScheme == .dark ? "-white" : "")", withExtension: "png")!
        }
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: GetImageUrl()) { img in
                img
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            } placeholder: {
                ProgressView()
            }
            
            Text(GetId())
                .font(.callout)
                .multilineTextAlignment(.center)
        }
    }
}

struct PokemonCardSmall_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCardSmall(PokeUtils.PokemonData.GetPokemonById(id: 100))
    }
}
