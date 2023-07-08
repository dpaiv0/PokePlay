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
    @StateObject private var viewModel = PokemonFightViewModel()
    
    @State var pokemonList: [ComplexPokemon]?
    @State var gym: Gym?
    
    @Environment(\.presentationMode) var presentation
    
    init() {
        self.viewModel.parent = self
    }
    
    init(_ pokemonList: [ComplexPokemon], _ gym: Gym) {
        self.viewModel.parent = self
        self.pokemonList = pokemonList
        self.gym = gym
    }
    
    var body: some View {
        VStack {
            ModalPresenter() {
                VStack {
                    VStack {
                        WebImage(url: PokeUtils.PokemonData.GetFrontPokemonSprite(id: viewModel.pokemon.pokemon.id), options: [.progressiveLoad])
                            .resizable()
                            .frame(width: 150, height: 150)
                        
                        Text(viewModel.pokemon.pokemon.name.capitalized)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        
                        Text("LVL. \(viewModel.pokemon.level)")
                            .font(.headline)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.center)
                        
                        ProgressView(value: viewModel.pokemon.getCurrentHp() < 0 ? 0 : viewModel.pokemon.getCurrentHp(), total: Double(viewModel.pokemon.getBaseHp()))
                            .accentColor(.green)
                            .frame(width: 100)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    
                    VStack {
                        WebImage(url: PokeUtils.PokemonData.GetBackPokemonSprite(id: viewModel.currentlyBattlingPokemon.pokemon.id), options: [.progressiveLoad])
                            .resizable()
                            .frame(width: 150, height: 150)
                        
                        Text(viewModel.currentlyBattlingPokemon.getNickname())
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        
                        Text("LVL. \(viewModel.currentlyBattlingPokemon.level)")
                            .font(.headline)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.center)
                        
                        ProgressView(value: viewModel.currentlyBattlingPokemon.getCurrentHp() < 0 ? 0 : viewModel.currentlyBattlingPokemon.getCurrentHp(), total: Double(viewModel.currentlyBattlingPokemon.getBaseHp()))
                            .accentColor(.green)
                            .frame(width: 100)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Text(viewModel.text)
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
                            viewModel.ActionOne()
                        } label: {
                            Text(viewModel.firstActionText)
                                .frame(maxWidth: 100)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .disabled(!viewModel.buttonsEnabled)
                        
                        Button {
                            viewModel.ActionTwo()
                        } label: {
                            Text(viewModel.secondActionText)
                                .frame(maxWidth: 100)
                        }
                        .sheet(isPresented: $viewModel.isPokemonActionSheetShowing) {
                            List {
                                ForEach(PokeUtils.PokemonTeamData.GetPokemonTeamFromUserDefaults().pokemonList, id: \.pokemon.id) { pokemon in
                                    Button {
                                        viewModel.currentlyBattlingPokemon = pokemon
                                        viewModel.isPokemonActionSheetShowing = false
                                        viewModel.UpdateText("\(viewModel.currentlyBattlingPokemon.getNickname()) is now in battle!")
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
                        .disabled(!viewModel.buttonsEnabled)
                        
                    }
                    HStack {
                        Button {
                            viewModel.ActionThree()
                        } label: {
                            Text(viewModel.thirdActionText)
                                .frame(maxWidth: 100)
                        }
                        .sheet(isPresented: $viewModel.isBagActionSheetShowing) {
                            List {
                                ForEach(Bag.GetBag(), id: \.sprite) { item in
                                    Button {
                                        viewModel.isBagActionSheetShowing = false
                                        viewModel.UpdateText("You used \(item.name)!")
                                        
                                        if item.name == "Potion" {
                                            viewModel.currentlyBattlingPokemon = viewModel.currentlyBattlingPokemon.heal(20)
                                        }
                                        
                                        if item.name == "Pokeball" {
                                            if viewModel.pokemon.getCurrentHp() < 20 {
                                                viewModel.UpdateText("You caught \(viewModel.pokemon.getNickname())!")
                                                
                                                viewModel.buttonsEnabled = false
                                                
                                                PokeUtils.PokemonTeamData.AppendPokemonToTeam(pokemon: viewModel.pokemon)
                                                
                                                PokeUtils.PokedexData.AppendPokemonToPokedex(pokemon: viewModel.pokemon.pokemon)
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                    presentation.wrappedValue.dismiss()
                                                }
                                            
                                            } else {
                                                viewModel.UpdateText("You need to weaken \(viewModel.pokemon.pokemon.name.capitalized) first!")
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
                        .disabled(!viewModel.buttonsEnabled)
                        
                        Button {
                            viewModel.ActionFour()
                        } label: {
                            Text(viewModel.fourthActionText)
                                .frame(maxWidth: 100)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .disabled(!viewModel.buttonsEnabled)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                
            }
            .onAppear() {
                if (pokemonList != nil) {
                    viewModel.pokemon = pokemonList![0]
                }
                
                viewModel.currentlyBattlingPokemon = PokeUtils.PokemonTeamData.GetFavoriteOrFirstPokemon()
                
                if viewModel.currentlyBattlingPokemon.isFainted() {
                    viewModel.currentlyBattlingPokemon = PokeUtils.PokemonTeamData.GetFirstNotFaintedPokemon() ?? ComplexPokemon(pokemon: PokeUtils.PokemonData.GetPokemonById(id: 1), level: 1)
                
                }
                
                viewModel.UpdateText("A wild \(viewModel.pokemon.pokemon.name.capitalized) has appeared!\nWhat will \(viewModel.currentlyBattlingPokemon.getNickname().capitalized) do?")
            }
            .alert(isPresented: $viewModel.runPressed) {
                Alert(title: Text("Are you sure you want to run?"), message: Text("You will not be able to battle this Pokémon again."), primaryButton: .destructive(Text("Run")) {
                    let random = Int.random(in: 1...2)
                    
                    if random == 1 {
                        viewModel.UpdateText("You got away safely!")
                        viewModel.buttonsEnabled = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.presentation.wrappedValue.dismiss()
                        }
                    } else {
                        viewModel.UpdateText("You couldn't get away!")
                    }
                    
                }, secondaryButton: .cancel())
            }
        }
    }
    
    struct PokemonFightView_Previews: PreviewProvider {
        static var previews: some View {
            PokemonFightView()
        }
    }
}
