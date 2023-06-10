//
//  PokedexView.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import SwiftUI

struct PokedexView: View {
    @State var parent: HomeScreen? = nil
    
    init() {
        self.parent = nil
    }
    
    init(_ parent: HomeScreen) {
        self.parent = parent
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
                        NavigationLink(destination: PokemonDetailsView(PokeUtils.GetPokemonById(id: id))) {
                            PokemonCardSmall(PokeUtils.GetPokemonById(id: id))
                        }
                        .disabled(PokeUtils.GetPokedexFromUserDefaults().pokemonList.firstIndex(where: { $0.id == id }) == nil)
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
