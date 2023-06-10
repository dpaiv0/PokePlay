//
//  PokemonDetailsView.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import SwiftUI

struct PokemonDetailsView: View {
    @State var pokemon: Pokemon
    
    init(_ pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailsView(PokeUtils.GetPokemonById(id: 1))
    }
}
