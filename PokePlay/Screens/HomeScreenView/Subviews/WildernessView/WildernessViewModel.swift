//
//  WildernessViewModel.swift
//  PokePlay
//
//  Created by David Paiva on 05/07/2023.
//

import Foundation

final class WildernessViewModel : ObservableObject {
    @Published var parent: HomeScreenViewModel? = nil
    @Published var walking = false;
    @Published var canNotBattle = false;
    @Published var timeRemaining = 7
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func StartWalking() -> Void {
        if (PokeUtils.PokemonTeamData.AllPokemonsFainted()) {
            canNotBattle = true
            return
        }
        
        walking = true
        
        let randomInt = Int.random(in: 3..<8)
        
        timeRemaining = randomInt
    }
    
    func GetWalkingImage() -> URL? {
        if (walking) {
            return Bundle.main.url(forResource: "tall-grass-walking", withExtension: "gif")
        } else {
            return Bundle.main.url(forResource: "tall-grass-walking-still", withExtension: "png")
        }
    }
    
    func StartFight() -> Void {
        walking = false
        
        let fightView = PokemonFightView()
        
        self.parent?.GoToFightView(fightView)
    }
}
