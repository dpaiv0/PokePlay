//
//  PokemonFightView.swift
//  PokePlay
//
//  Created by David Paiva on 17/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonFightView: View {
    @State var pokemon: ComplexPokemon
    
    @State private var text = ""
    
    @State private var timeRemaining = 2
    
    init(_ pokemon: ComplexPokemon) {
        self.pokemon = pokemon
    }
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var buttonsEnabled: Bool = true
    
    func UpdateText(_ text: String) -> Void {
        self.text = text
    }
    
    @State private var currentlyBattlingPokemon = PokeUtils.PokemonTeamData.GetFavoriteOrFirstPokemon()
    
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
                    
                    Text("Lv. \(pokemon.level)")
                        .font(.headline)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                    
                    ProgressView(value: Float(pokemon.getHp() / pokemon.getHp()))
                        .accentColor(Float(pokemon.getHp() / pokemon.getHp()) <= 0.5 ? (
                            Float(pokemon.getHp() / pokemon.getHp()) <= 0.25 ? .red : .yellow
                        ) : .green)
                        .frame(width: 100)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                
                VStack {
                    WebImage(url: PokeUtils.PokemonData.GetBackPokemonSprite(id: currentlyBattlingPokemon?.pokemon.id ?? 1), options: [.progressiveLoad])
                        .resizable()
                        .frame(width: 150, height: 150)
                    
                    Text(currentlyBattlingPokemon?.pokemon.name.capitalized ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    Text("Lv. \(currentlyBattlingPokemon?.level ?? 1)")
                        .font(.headline)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                    
                    ProgressView(value: Float((currentlyBattlingPokemon?.getHp() ?? 1) / (currentlyBattlingPokemon?.getHp() ?? 1)))
                        .accentColor(Float(currentlyBattlingPokemon?.getHp() ?? 1 / (currentlyBattlingPokemon?.getHp() ?? 1)) <= 0.5 ? (
                            Float(currentlyBattlingPokemon?.getHp() ?? 1 / (currentlyBattlingPokemon?.getHp() ?? 1)) <= 0.25 ? .red : .yellow
                        ) : .green)
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
                        
                    } label: {
                        Text("Fight")
                            .frame(maxWidth: 75)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .disabled(!buttonsEnabled)
                    .padding()
                    
                    Button {
                        
                    } label: {
                        Text("Pokémon")
                            .frame(maxWidth: 75)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .disabled(!buttonsEnabled)
                    .padding()
                    
                    
                }
                HStack {
                    Button {
                        
                    } label: {
                        Text("Item")
                            .frame(maxWidth: 75)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .disabled(!buttonsEnabled)
                    .padding()
                    
                    Button {
                        
                    } label: {
                        Text("Run")
                            .frame(maxWidth: 75)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .disabled(!buttonsEnabled)
                    .padding()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.init(hex: "#FAFAFA" ).clipShape(RoundedRectangle(cornerRadius: 20)))
            
        }
        .onAppear() {
            UpdateText("A wild \(pokemon.pokemon.name.capitalized) has appeared!\nWhat will \(currentlyBattlingPokemon?.pokemon.name.capitalized ?? "") do?")
        }
    }
    
}

struct PokemonFightView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonFightView(ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 48), level: 5))
    }
}
