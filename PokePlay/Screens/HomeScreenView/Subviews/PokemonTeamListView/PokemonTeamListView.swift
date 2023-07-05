//
//  PokemonTeamListView.swift
//  PokePlay
//
//  Created by David Paiva on 13/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine

struct PokemonTeamListView: View {
    @StateObject private var viewModel = PokemonTeamListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Team")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                
                List {
                    ForEach(viewModel.pokemonTeam.pokemonList, id: \.pokemon.id) { pokemon in
                        HStack {
                            NavigationLink(destination: PokemonDetailsView(pokemon.pokemon).toolbar(.hidden)) {
                                WebImage(url: PokeUtils.PokemonData.GetFrontPokemonSprite(id: pokemon.pokemon.id), options: [.progressiveLoad])
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                VStack(alignment: .leading) {
                                    Text("\(pokemon.getNickname())  \(pokemon.isFavorite() ? "⭐️" : "")")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    
                                    Text("Level \(pokemon.level)")
                                        .font(.subheadline)
                                    
                                    Text("HP: \(Int(pokemon.getCurrentHp()))/\(pokemon.getBaseHp())")
                                        .font(.subheadline)
                                    
                                    Text("Attack: \(pokemon.getAttack())")
                                        .font(.subheadline)
                                    
                                }
                            }
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                viewModel.showingDeleteAlert.toggle()
                                viewModel.selectedPokemon = pokemon
                            } label: {
                                Label("Release", systemImage: "leaf")
                            }
                            
                            Button {
                                viewModel.selectedPokemon = pokemon
                                viewModel.FavoritePokemon()
                            } label: {
                                Label(pokemon.isFavorite() ? "Unfavorite" : "Favorite", systemImage: pokemon.isFavorite() ? "star.slash" : "star")
                            }
                            .tint(Color.yellow)
                            
                            Button {
                                viewModel.showingEditAlert.toggle()
                                viewModel.selectedPokemon = pokemon
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(Color.green)
                        }
                        .confirmationDialog("Are you sure you want to release \(pokemon.getNickname())?", isPresented: $viewModel.showingDeleteAlert) {
                            Button("Release", role: .destructive) {
                                viewModel.DeletePokemon()
                            }
                        } message:
                        {
                            Text("Are you sure you want to release \(pokemon.getNickname())?")
                        }
                    }
                    .alert("Edit \(viewModel.selectedPokemon?.getNickname() ?? "Pokémon")'s nickname", isPresented: $viewModel.showingEditAlert) {
                        
                        TextField("Nickname", text: $viewModel.pokemonNickname)
                            .onReceive(Just(viewModel.pokemonNickname)) { _ in viewModel.limitText(15) }
                        Button("Submit") {
                            viewModel.EditNickname()
                        }
                    }
                    .alert(isPresented: $viewModel.cannotDeleteLastPokemonAlert,
                           content: { self.viewModel.CantDeletePokemon() })
                }
                .onAppear() {
                    viewModel.pokemonTeam = PokeUtils.PokemonTeamData.GetPokemonTeamFromUserDefaults()
                }
            }
        }
    }
}


struct PokemonTeamListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTeamListView()
    }
}
