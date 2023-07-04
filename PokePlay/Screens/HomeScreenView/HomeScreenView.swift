//
//  HomeScreen.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeScreenView: View {
    @StateObject var viewModel = HomeScreenViewModel()

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: viewModel.pokemonFightView?.navigationBarBackButtonHidden(true), isActive: $viewModel.goToPokemonFightView) { EmptyView() }
                
                // Header
                HStack(spacing: 0) {
                    HStack {
                        NavigationLink(destination: PokemonTeamListView()) {
                            WebImage(url: PokeUtils.PokemonData.GetFrontPokemonSprite(id: viewModel.favoritePokemon.pokemon.id), options: [.progressiveLoad])
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text("\(viewModel.favoritePokemon.getNickname())\nLVL. \(viewModel.favoritePokemon.level)")
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .frame(maxWidth: viewModel.headerItemWidth)
                    
                    Text("PokéPlay")
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: viewModel.headerItemWidth)
                    
                    HStack {
                        NavigationLink(destination: UserPreferencesView()) {
                            Spacer()
                            Text("\(viewModel.name)")
                                .font(.caption)
                                .multilineTextAlignment(.trailing)
                            WebImage(url: Bundle.main.url(forResource: "pkmn-\(viewModel.gender)-still", withExtension: "png")!, options: [.progressiveLoad])
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .frame(maxWidth: viewModel.headerItemWidth)
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                
                // Main Content
                VStack {
                    viewModel.GetScreen()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Footer
                Divider()
                
                HStack(spacing: 0) {
                    TabButton(title: "Wilderness", iconName: "leaf.fill", selected: viewModel.screen == "wilderness")
                        .frame(width: viewModel.tabButtonWidth)
                        .onTapGesture {
                            viewModel.screen = "wilderness"
                        }
                    
                    TabButton(title: "Pokédex", iconName: "book.closed.fill", selected: viewModel.screen == "pokedex")
                        .frame(width: viewModel.tabButtonWidth)
                        .onTapGesture {
                            viewModel.screen = "pokedex"
                        }
                    
                    TabButton(title: "Gyms", iconName: "building.2.fill", selected: viewModel.screen == "gyms")
                        .frame(width: viewModel.tabButtonWidth)
                        .onTapGesture {
                            viewModel.screen = "gyms"
                        }
                    
                    TabButton(title: "Poké Center", iconName: "cross.case.fill", selected: viewModel.screen == "pokecenter")
                        .frame(width: viewModel.tabButtonWidth)
                        .onTapGesture {
                            viewModel.screen = "pokecenter"
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .onAppear() {
                    viewModel.RenderView()
                }
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
