//
//  PokeCenterViewModel.swift
//  PokePlay
//
//  Created by David Paiva on 05/07/2023.
//

import Foundation

final class PokeCenterViewModel : ObservableObject {
    
    @Published var healing = false
    @Published var parent: HomeScreenViewModel?
    @Published var timeRemaining = 8
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func GetHealingImage() -> URL? {
        if (healing) {
            return Bundle.main.url(forResource: "poke-center-healing", withExtension: "gif")
        } else {
            return Bundle.main.url(forResource: "poke-center-healing-still", withExtension: "png")
        }
    }
    
    func StartHealing() -> Void {
        healing = true
    }
    
    func Heal() -> Void {
        healing = false
        timer.upstream.connect().cancel()
        PokeUtils.PokemonTeamData.HealPokemonTeam()
    }
}
