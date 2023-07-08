//
//  PokemonSpriteView.swift
//  PokePlay
//
//  Created by David Paiva on 08/07/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonSpriteView: View {
    @State var pokemon: ComplexPokemon
    
    init(_ pokemon: ComplexPokemon) {
        self.pokemon = pokemon
    }
    
    var body: some View {
        HStack {
            WebImage(url: PokeUtils.PokemonData.GetFrontPokemonSprite(id: pokemon.pokemon.id))
                .resizable()
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading) {
                Text(pokemon.getNickname())
                    .font(.body)
                    .multilineTextAlignment(.leading)
                
                Text("Level: \(pokemon.level)")
                    .font(.body)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

struct PokemonSpriteView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonSpriteView(ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 13)))
    }
}
