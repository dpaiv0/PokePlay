//
//  PokemonFightViewModel.swift
//  PokePlay
//
//  Created by David Paiva on 05/07/2023.
//

import Foundation

final class PokemonFightViewModel : ObservableObject {
    @Published var pokemon: ComplexPokemon = ComplexPokemon(pokemon: CpuFight.GetRandomPokemon(), level: PokeUtils.PokemonTeamData.GetFavoriteOrFirstPokemon().level)
    @Published var text = ""
    @Published var timeRemaining = 2
    @Published var runPressed = false
    @Published var isPokemonActionSheetShowing = false
    @Published var isBagActionSheetShowing = false
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var buttonsEnabled: Bool = true
    @Published var currentlyBattlingPokemon = ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 1))
    @Published var firstActionText = "Fight"
    @Published var secondActionText = "Pokémon"
    @Published var thirdActionText = "Bag"
    @Published var fourthActionText = "Run"
    
    var parent: PokemonFightView? = nil
    
    func UpdateText(_ text: String) -> Void {
        self.text = text
    }
    
    func Attack(move: Move) {
        UpdateText("\(currentlyBattlingPokemon.getNickname().capitalized) used \(move.move.name.capitalized)!")
        
        buttonsEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            let effectiveness = Double(Weakness.CalculateTypeEffectiveness(attackingPokemon: currentlyBattlingPokemon, defendingPokemon: pokemon, move: move))
            
            switch effectiveness {
            case 0.0:
                UpdateText("It had no effect!")
            case 0.25:
                UpdateText("It's not very effective...")
            case 0.5:
                UpdateText("It's not very effective...")
            case 2.0:
                UpdateText("It's super effective!")
            default:
                UpdateText("It's effective!")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                self.pokemon = Weakness.DealDamage(defendingPokemon: pokemon, damage: Int(Double(currentlyBattlingPokemon.pokemon.moves[0].move.power) * effectiveness) + 1)
                
                
                if pokemon.isFainted() {
                    let randomXP = Int.random(in: 50...100)
                    
                    UpdateText("\(currentlyBattlingPokemon.getNickname().capitalized) defeated \(pokemon.pokemon.name.capitalized) and gained \(randomXP) XP!")
                    
                    pokemon.setCurrentHealth(currentHealth: 0.0)
                    
                    currentlyBattlingPokemon.addXp(xp: randomXP)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.parent?.presentation.wrappedValue.dismiss()
                    }
                } else {
                    
                    let botMove = Int.random(in: 0...3)
                    
                    UpdateText("\(pokemon.pokemon.name.capitalized) used \(pokemon.pokemon.moves[botMove].move.name.capitalized)!")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                        let effectiveness = Double(Weakness.CalculateTypeEffectiveness(attackingPokemon: pokemon, defendingPokemon: currentlyBattlingPokemon, move: pokemon.pokemon.moves[botMove]))
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                            currentlyBattlingPokemon = Weakness.DealDamage(defendingPokemon: currentlyBattlingPokemon, damage: Int(Double(pokemon.pokemon.moves[botMove].move.power) * effectiveness))
                            
                            if currentlyBattlingPokemon.isFainted() {
                                UpdateText("\(currentlyBattlingPokemon.getNickname().capitalized) fainted!")
                                
                                currentlyBattlingPokemon.setCurrentHealth(currentHealth: 0.0)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
                                    
                                    if PokeUtils.PokemonTeamData.GetFirstNotFaintedPokemon() == nil {
                                        UpdateText("You have no more Pokémon to battle with!")
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            self.parent?.presentation.wrappedValue.dismiss()
                                        }
                                    } else {
                                        currentlyBattlingPokemon = PokeUtils.PokemonTeamData.GetFirstNotFaintedPokemon() ?? ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 1), level: 1)
                                        
                                        UpdateText("What will \(currentlyBattlingPokemon.getNickname().capitalized) do?")
                                        
                                        buttonsEnabled = true
                                        
                                        firstActionText = "Fight"
                                        secondActionText = "Pokémon"
                                        thirdActionText = "Bag"
                                        fourthActionText = "Run"
                                    }
                                }
                            } else {
                                UpdateText("\(currentlyBattlingPokemon.getNickname().capitalized) has \(Int(currentlyBattlingPokemon.getCurrentHp())) HP remaining!")
                                
                                buttonsEnabled = true
                                
                                firstActionText = "Fight"
                                secondActionText = "Pokémon"
                                thirdActionText = "Bag"
                                fourthActionText = "Run"
                            }
                        }
                    }
                }
            }
        }
    }
    
    func ActionOne() -> Void {
        let moves = currentlyBattlingPokemon.pokemon.moves

        if (firstActionText == "Fight") {
            firstActionText = moves[0].move.name.capitalized
            secondActionText = moves[1].move.name.capitalized
            thirdActionText = moves[2].move.name.capitalized
            fourthActionText = moves[3].move.name.capitalized
        } else {
            Attack(move: moves[0])
        }
    }
    
    func ActionTwo() -> Void {
        if (secondActionText == "Pokémon") {
            isPokemonActionSheetShowing = true
        } else {
            let moves = currentlyBattlingPokemon.pokemon.moves
            Attack(move: moves[1])
        }
    }
    
    func ActionThree() -> Void {
        if (thirdActionText == "Bag") {
            isBagActionSheetShowing = true
        } else {
            let moves = currentlyBattlingPokemon.pokemon.moves
            Attack(move: moves[2])
        }
    }
    
    func ActionFour() -> Void {
        if (fourthActionText == "Run") {
            runPressed = true
        } else {
            let moves = currentlyBattlingPokemon.pokemon.moves
            Attack(move: moves[3])
        }
    }
}
