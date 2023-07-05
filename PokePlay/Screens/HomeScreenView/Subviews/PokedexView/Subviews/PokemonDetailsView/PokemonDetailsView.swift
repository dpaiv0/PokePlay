//
//  PokemonDetailsView.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonDetailsView: View {
    @StateObject private var viewModel = PokemonDetailsViewModel()
    
    init(_ pokemon: Pokemon) {
        self.viewModel.pokemon = pokemon
    }
    
    var body: some View {        
        VStack {
            Text("Pokédex Entry #\(viewModel.GetId(viewModel.pokemon.id))")
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(viewModel.pokemon.name.capitalized)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)            
            WebImage(url: PokeUtils.PokemonData.GetFrontPokemonSprite(id: viewModel.pokemon.id), options: [.progressiveLoad])
                .frame(width: 200, height: 200)
                .background(Color(hex: PokeUtils.PokemonData.GetColorForPokemonType(pokemon: viewModel.pokemon)))
                .cornerRadius(30)
            
            Text("Type\(viewModel.pokemon.types.count > 1 ? "s" : ""): \(viewModel.pokemon.types.map { $0.type.name.capitalized }.joined(separator: ", "))")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
            
            Text("Moves: \(viewModel.pokemon.moves.map { $0.move.name.replacingOccurrences(of: "-", with: " ").capitalized }.joined(separator: ", "))")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
                .frame(width: 300)
            
            Text("Height: \(viewModel.pokemon.height)")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
            
            Text("Weight: \(viewModel.pokemon.weight)")
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
