//
//  SelectStarterScreenViewModel.swift
//  PokePlay
//
//  Created by David Paiva on 04/07/2023.
//

import Foundation

final class SelectStarterScreenViewModel : ObservableObject {
    @Published var starter = 0
    @Published var goingToNextScreen = false
    @Published var starters = [1, 4, 7]
    
    func selectStarter() {
        let starterData = PokeUtils.PokemonData.GetPokemonById(id: starter)
        
        PokeUtils.PokedexData.AppendPokemonToPokedex(pokemon: starterData)
        
        PokeUtils.PokemonTeamData.AppendPokemonToTeam(pokemon: ComplexPokemon(pokemon: starterData, level: 5))
        
        PokeUtils.PokemonTeamData.SetFavoritePokemon(pokemon: PokeUtils.PokemonTeamData.GetPokemonTeamFromUserDefaults().pokemonList[0])
        
        SettingsUtils.SetSetting(key: "render_badges", value: true)
        
        self.goingToNextScreen = true
    }
}
