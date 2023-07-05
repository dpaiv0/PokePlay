//
//  PokedexView.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import SwiftUI

struct PokedexView: View {
    @StateObject private var viewModel = PokedexViewModel()
    
    init() {
        self.viewModel.parent = nil
    }
    
    init(_ parent: HomeScreenViewModel) {
        self.viewModel.parent = parent
    }
    
    var body: some View {
        VStack {
            Text("Pokédex")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 30) {
                    ForEach(1..<152) { id in
                        NavigationLink(destination: PokemonDetailsView(PokeUtils.PokemonData.GetPokemonById(id: id))) {
                            PokemonCardSmall(PokeUtils.PokemonData.GetPokemonById(id: id))
                        }
                        .disabled(PokeUtils.PokedexData.GetPokedexFromUserDefaults().pokemonList.firstIndex(where: { $0.id == id }) == nil)
                    }
                }
                .padding(.top, 20)
            }
            
        }
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}
