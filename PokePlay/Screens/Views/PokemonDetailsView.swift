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
    
    func GetId(_ id: Int) -> String {
        if (1...9).contains(id) {
            return "00\(id)"
        } else if (10...99).contains(id) {
            return "0\(id)"
        } else {
            return "\(id)"
        }
    }
    
    var body: some View {        
        VStack {
            Text("Pokédex Entry #\(GetId(pokemon.id))")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(pokemon.name.capitalized)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)            
            WebImage(url: PokeUtils.PokemonData.GetFrontPokemonSprite(id: pokemon.id), options: [.progressiveLoad])
                .frame(width: 200, height: 200)
                .background(Color(hex: PokeUtils.PokemonData.GetColorForPokemonType(pokemon: pokemon)))
                .cornerRadius(30)
            
            Text("Type\(pokemon.types.count > 1 ? "s" : ""): \(pokemon.types.map { $0.type.name.capitalized }.joined(separator: ", "))")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
            
            Text("Moves: \(pokemon.moves.map { $0.move.name.replacingOccurrences(of: "-", with: " ").capitalized }.joined(separator: ", "))")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
                .frame(width: 300)
            
            Text("Height: \(pokemon.height)")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
            
            Text("Weight: \(pokemon.weight)")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
        }
    
    }
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView(PokeUtils.PokemonData.GetPokemonById(id: 1))
    }
}
