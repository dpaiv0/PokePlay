//
//  PokemonTeamListViewModel.swift
//  PokePlay
//
//  Created by David Paiva on 05/07/2023.
//

import Foundation
import SwiftUI

final class PokemonTeamListViewModel : ObservableObject {
    @Published var showingEditAlert = false
    @Published var showingDeleteAlert = false
    @Published var showingFavoriteAlert = false
    
    @Published var cannotDeleteLastPokemonAlert = false
    
    @Published var pokemonNickname = ""
    @Published var selectedPokemon: ComplexPokemon? = nil
    
    @Published var pokemonTeam = PokeUtils.PokemonTeamData.GetPokemonTeamFromUserDefaults()
    
    func EditNickname()
    {
        if
            var pokemon = selectedPokemon
        {
            pokemon.setNickname(nickname: pokemonNickname)
            pokemonTeam = PokeUtils.PokemonTeamData.UpdatePokemonFromTeam(pokemon: pokemon)
            
            pokemonNickname = ""
            print(pokemonTeam)
        }
    }
    
    
    func DeletePokemon() {
        
        if
            let pokemon = selectedPokemon
        {
            if PokeUtils.PokemonTeamData.GetPokemonTeamCount() == 1 {
                cannotDeleteLastPokemonAlert.toggle()
                return
            }
            
            pokemonTeam = PokeUtils.PokemonTeamData.RemovePokemonFromTeam(pokemon: pokemon)
        }
    }
    
    func CantDeletePokemon() -> Alert {
        if let pokemon = selectedPokemon {
            return Alert(title: Text("Can't release \(pokemon.getNickname())"), message: Text("You can't release your last Pokémon"), dismissButton: .default(Text("Got it!")))
        }
        
        return Alert(title: Text("Can't release Pokémon"), message: Text("You can't release your last Pokémon"), dismissButton: .default(Text("Got it!")))
    }
    
    
    func FavoritePokemon() {
        if
            let pokemon = selectedPokemon
        {
            
            pokemonTeam = PokeUtils.PokemonTeamData.SetFavoritePokemon(pokemon: pokemon)
        }
    }
    
    func limitText(_ upper: Int) {
        if pokemonNickname.count > upper {
            pokemonNickname = String(pokemonNickname.prefix(upper))
        }
    }
}
