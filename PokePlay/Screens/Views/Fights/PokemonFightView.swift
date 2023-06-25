//
//  PokemonFightView.swift
//  PokePlay
//
//  Created by David Paiva on 17/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI
import ModalView

struct PokemonFightView: View {
    @State private var pokemon: ComplexPokemon = ComplexPokemon(pokemon: CpuFight.GetRandomPokemon(), level: PokeUtils.PokemonTeamData.GetFavoriteOrFirstPokemon().level)
    
    @State private var text = ""
    
    @State private var timeRemaining = 2
    
    @State private var runPressed = false
    
    @State private var isPokemonActionSheetShowing = false
    
    @State private var isBagActionSheetShowing = false
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var buttonsEnabled: Bool = true
    
    func UpdateText(_ text: String) -> Void {
        self.text = text
    }
    
    @State private var currentlyBattlingPokemon = ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 1))
    
    @Environment(\.presentationMode) var presentation
    
    @State private var firstActionText = "Fight"
    
    @State private var secondActionText = "Pokémon"
    
    @State private var thirdActionText = "Bag"
    
    @State private var fourthActionText = "Run"
    
    var body: some View {
        VStack {
            ModalPresenter() {
                VStack {
                    VStack {
                        WebImage(url: PokeUtils.PokemonData.GetFrontPokemonSprite(id: pokemon.pokemon.id), options: [.progressiveLoad])
                            .resizable()
                            .frame(width: 150, height: 150)
                        
                        Text(pokemon.pokemon.name.capitalized)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        
                        Text("LVL. \(pokemon.level)")
                            .font(.headline)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.center)
                        
                        ProgressView(value: pokemon.getCurrentHp() < 0 ? 0 : pokemon.getCurrentHp(), total: Double(pokemon.getBaseHp()))
                            .accentColor(.green)
                            .frame(width: 100)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    
                    VStack {
                        WebImage(url: PokeUtils.PokemonData.GetBackPokemonSprite(id: currentlyBattlingPokemon.pokemon.id), options: [.progressiveLoad])
                            .resizable()
                            .frame(width: 150, height: 150)
                        
                        Text(currentlyBattlingPokemon.getNickname())
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        
                        Text("LVL. \(currentlyBattlingPokemon.level)")
                            .font(.headline)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.center)
                        
                        ProgressView(value: currentlyBattlingPokemon.getCurrentHp() < 0 ? 0 : currentlyBattlingPokemon.getCurrentHp(), total: Double(currentlyBattlingPokemon.getBaseHp()))
                            .accentColor(.green)
                            .frame(width: 100)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Text(text)
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Spacer()
                // Actions
                VStack {
                    HStack {
                        Button {
                            ActionOne()
                        } label: {
                            Text(firstActionText)
                                .frame(maxWidth: 100)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .disabled(!buttonsEnabled)
                        
                        Button {
                            ActionTwo()
                        } label: {
                            Text(secondActionText)
                                .frame(maxWidth: 100)
                        }
                        .sheet(isPresented: $isPokemonActionSheetShowing) {
                            List {
                                ForEach(PokeUtils.PokemonTeamData.GetPokemonTeamFromUserDefaults().pokemonList, id: \.pokemon.id) { pokemon in
                                    Button {
                                        currentlyBattlingPokemon = pokemon
                                        isPokemonActionSheetShowing = false
                                        UpdateText("\(currentlyBattlingPokemon.getNickname()) is now in battle!")
                                    } label: {
                                        HStack {
                                            WebImage(url: PokeUtils.PokemonData.GetFrontPokemonSprite(id: pokemon.pokemon.id), options: [.progressiveLoad])
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            
                                            Text(pokemon.getNickname())
                                                .font(.headline)
                                                .fontWeight(.regular)
                                                .multilineTextAlignment(.center)
                                            
                                            Text("LVL. \(pokemon.level)")
                                                .font(.headline)
                                                .fontWeight(.regular)
                                                .multilineTextAlignment(.center)
                                            
                                            Spacer()
                                        }
                                    }
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .disabled(!buttonsEnabled)
                        
                    }
                    HStack {
                        Button {
                            ActionThree()
                        } label: {
                            Text(thirdActionText)
                                .frame(maxWidth: 100)
                        }
                        .sheet(isPresented: $isBagActionSheetShowing) {
                            List {
                                ForEach(Bag.GetBag(), id: \.sprite) { item in
                                    Button {
                                        isBagActionSheetShowing = false
                                        UpdateText("You used \(item.name)!")
                                        
                                        if item.name == "Potion" {
                                            currentlyBattlingPokemon = currentlyBattlingPokemon.heal(20)
                                        }
                                        
                                        if item.name == "Pokeball" {
                                            if pokemon.getCurrentHp() < 20 {
                                                UpdateText("You caught \(pokemon.getNickname())!")
                                                
                                                PokeUtils.PokemonTeamData.AppendPokemonToTeam(pokemon: pokemon)
                                                
                                                PokeUtils.PokedexData.AppendPokemonToPokedex(pokemon: pokemon.pokemon)
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                    presentation.wrappedValue.dismiss()
                                                }
                                            
                                            } else {
                                                UpdateText("You need to weaken \(pokemon.pokemon.name.capitalized) first!")
                                            }
                                        }
                                    } label: {
                                        HStack {
                                            WebImage(url: URL(string: item.sprite)!, options: [.progressiveLoad])
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            
                                            Text(item.name)
                                                .font(.headline)
                                                .fontWeight(.regular)
                                                .multilineTextAlignment(.center)
                                            
                                            Spacer()
                                            
                                            Text("x ∞")
                                                .font(.subheadline)
                                                .fontWeight(.light)
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                }
                            }
                            
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .disabled(!buttonsEnabled)
                        
                        Button {
                            ActionFour()
                        } label: {
                            Text(fourthActionText)
                                .frame(maxWidth: 100)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .disabled(!buttonsEnabled)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                
            }
            .onAppear() {
                currentlyBattlingPokemon = PokeUtils.PokemonTeamData.GetFavoriteOrFirstPokemon()
                
                if currentlyBattlingPokemon.isFainted() {
                    currentlyBattlingPokemon = PokeUtils.PokemonTeamData.GetFirstNotFaintedPokemon() ?? ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 1), level: 1)
                
                }
                
                UpdateText("A wild \(pokemon.pokemon.name.capitalized) has appeared!\nWhat will \(currentlyBattlingPokemon.getNickname().capitalized) do?")
            }
            .alert(isPresented: $runPressed) {
                Alert(title: Text("Are you sure you want to run?"), message: Text("You will not be able to battle this Pokémon again."), primaryButton: .destructive(Text("Run")) {
                    let random = Int.random(in: 1...2)
                    
                    if random == 1 {
                        UpdateText("You got away safely!")
                        buttonsEnabled = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.presentation.wrappedValue.dismiss()
                        }
                    } else {
                        UpdateText("You couldn't get away!")
                    }
                    
                }, secondaryButton: .cancel())
            }
        }
    }
    
    func Attack(move: Move) {
        UpdateText("\(currentlyBattlingPokemon.getNickname().capitalized) used \(move.move.name.capitalized)!")
        
        buttonsEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.pokemon = Weakness.DealDamage(defendingPokemon: pokemon, damage: Int(Double(currentlyBattlingPokemon.pokemon.moves[0].move.power) * effectiveness) + 1)
                
                
                if pokemon.isFainted() {
                    UpdateText("\(currentlyBattlingPokemon.getNickname().capitalized) defeated \(pokemon.pokemon.name.capitalized)!")
                    
                    pokemon.setCurrentHealth(currentHealth: 0.0)
                    
                    let randomXP = Int.random(in: 50...100)
                    
                    currentlyBattlingPokemon.addXp(xp: randomXP)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.presentation.wrappedValue.dismiss()
                    }
                } else {
                    
                    let botMove = Int.random(in: 0...3)
                    
                    UpdateText("\(pokemon.pokemon.name.capitalized) used \(pokemon.pokemon.moves[botMove].move.name.capitalized)!")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        let effectiveness = Double(Weakness.CalculateTypeEffectiveness(attackingPokemon: pokemon, defendingPokemon: currentlyBattlingPokemon, move: pokemon.pokemon.moves[botMove]))
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            currentlyBattlingPokemon = Weakness.DealDamage(defendingPokemon: currentlyBattlingPokemon, damage: Int(Double(pokemon.pokemon.moves[botMove].move.power) * effectiveness))
                            
                            if currentlyBattlingPokemon.isFainted() {
                                UpdateText("\(currentlyBattlingPokemon.getNickname().capitalized) fainted!")
                                
                                currentlyBattlingPokemon.setCurrentHealth(currentHealth: 0.0)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    
                                    if PokeUtils.PokemonTeamData.GetFirstNotFaintedPokemon() == nil {
                                        UpdateText("You have no more Pokémon to battle with!")
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            self.presentation.wrappedValue.dismiss()
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
    
    struct PokemonFightView_Previews: PreviewProvider {
        static var previews: some View {
            PokemonFightView()
        }
    }
}
