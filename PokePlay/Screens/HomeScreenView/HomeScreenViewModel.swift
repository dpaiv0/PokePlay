//
//  HomeScreenViewModel.swift
//  PokePlay
//
//  Created by David Paiva on 04/07/2023.
//

import Foundation
import UIKit
import SwiftUI

final class HomeScreenViewModel : ObservableObject {
    @Published var tabButtonWidth: CGFloat = UIScreen.main.bounds.width / 3
    @Published var headerItemWidth: CGFloat = UIScreen.main.bounds.width / 3
    
    @Published var gender = "male";
    @Published var name = "";
    
    @Published var screen: String = "wilderness"
    
    @Published var favoritePokemon: ComplexPokemon = ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 1))
    
    @Published var pokemonFightView: PokemonFightView?
    @Published var goToPokemonFightView = false
    
    func GoToFightView(_ fightView: PokemonFightView) -> Void {
        pokemonFightView = fightView
        goToPokemonFightView = true
    }
    
    func GetScreen() -> AnyView {
        switch screen {
        case "pokedex":
            return AnyView(PokedexView(self))
        case "wilderness":
            return AnyView(WildernessView(self))
        case "pokecenter":
            return AnyView(PokeCenterView(self))
        default:
            return AnyView(Text("Hello, world!"))
        }
    }
    
    func RenderView() {
        favoritePokemon = PokeUtils.PokemonTeamData.GetFavoriteOrFirstPokemon()
        gender = SettingsUtils.GetSetting(key: "gender") as! String
        name = SettingsUtils.GetSetting(key: "name") as! String
    }
}
