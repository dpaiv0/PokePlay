//
//  PokemonCardSmall.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonCardSmall: View {
    @State private var pokemon: Pokemon
    
    init(_ pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
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
        
        if let index = PokeUtils.GetPokedexFromUserDefaults().pokemonList.firstIndex(where: { $0.id == pokemon.id }) {
            return PokeUtils.GetFrontPokemonSprite(id: pokemon.id)!
        } else {
            return Bundle.main.url(forResource: "question-mark-pixelated", withExtension: "png")!
        }
    }
    
    var body: some View {
        VStack {
            WebImage(url: GetImageUrl(), options: [.progressiveLoad])
                .resizable()
                .frame(width: 80, height: 80)
            
            Text(GetId())
                .font(.callout)
                .multilineTextAlignment(.center)
        }
    }
}

struct PokemonCardSmall_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCardSmall(PokeUtils.GetPokemonById(id: 100))
    }
}
