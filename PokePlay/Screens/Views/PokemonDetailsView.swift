//
//  PokemonDetailsView.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonDetailsView: View {
    @State var pokemon: Pokemon
    
    init(_ pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    var body: some View {        
        VStack {
            Text(pokemon.name.capitalized)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            WebImage(url: PokeUtils.GetFrontPokemonSprite(id: pokemon.id), options: [.progressiveLoad])
                .frame(width: 200, height: 200)
                .background(Color(hex: PokeUtils.GetColorForPokemonType(pokemon: pokemon)))
                .cornerRadius(30)
            
            Text("Type\(pokemon.types.count > 1 ? "s" : ""): \(pokemon.types.map { $0.type.name.capitalized }.joined(separator: ", "))")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
            
            Text("Height: \(pokemon.height)")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
            
            Text("Weight: \(pokemon.weight)")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
            
            Text("Moves: \(pokemon.moves.map { $0.move.name.replacingOccurrences(of: "-", with: " ").capitalized }.joined(separator: ", "))")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
        }
    
    }
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView(PokeUtils.GetPokemonById(id: 1))
    }
}
