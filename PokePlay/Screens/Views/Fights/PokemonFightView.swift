//
//  PokemonFightView.swift
//  PokePlay
//
//  Created by David Paiva on 17/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonFightView: View {
    
    init(_ pokemon: ComplexPokemon) {
        self.pokemon = pokemon
    }
    
    private var pokemon: ComplexPokemon = ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 1))
    
    @State private var text = ""
    
    @State private var timeRemaining = 2
    
    @State private var runPressed = false
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var buttonsEnabled: Bool = true
    
    func UpdateText(_ text: String) -> Void {
        self.text = text
    }
    
    @State private var currentlyBattlingPokemon = ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 1))
    
    @Environment(\.presentationMode) var presentation

    var body: some View {
        VStack {
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
                    
                    ProgressView(value: pokemon.getCurrentHp(), total: Double(pokemon.getBaseHp()))
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
                    
                    ProgressView(value: currentlyBattlingPokemon.getCurrentHp(), total: Double(currentlyBattlingPokemon.getBaseHp()))
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
                        // runPressed = true
                    } label: {
                        Text("Fight")
                            .frame(maxWidth: 100)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .disabled(!buttonsEnabled)
                    
                    Button {
                        // actions[1].action()
                    } label: {
                        Text("Pokémon")
                            .frame(maxWidth: 100)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .disabled(!buttonsEnabled)
                    
                }
                HStack {
                    Button {
                        // actions[2].action()
                    } label: {
                        Text("Bag")
                            .frame(maxWidth: 100)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .disabled(!buttonsEnabled)
                    
                    Button {
                        runPressed = true
                    } label: {
                        Text("Run")
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
            
            UpdateText("A wild \(pokemon.pokemon.name.capitalized) has appeared!\nWhat will \(currentlyBattlingPokemon.pokemon.name.capitalized) do?")
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
//        .alert(isPresented: $pokemon.isFainted) {
//            Alert(title: Text("Your Pokémon fainted!"), message: Text("You blacked out!"), dismissButton: .default(Text("OK")) {
//                print("Fainted")
//            })
//        }
    }
    
    struct PokemonFightView_Previews: PreviewProvider {
        static var previews: some View {
            PokemonFightView(ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 48), level: 5))
        }
    }
}
