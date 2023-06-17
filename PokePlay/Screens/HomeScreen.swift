//
//  HomeScreen.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeScreen: View {
    let tabButtonWidth: CGFloat = UIScreen.main.bounds.width / 4
    let headerItemWidth: CGFloat = UIScreen.main.bounds.width / 3
    
    @AppStorage("starter") private var starter = 0;
    @AppStorage("gender") private var gender = "male";
    @AppStorage("name") private var name = "";
    @AppStorage("currency") private var currency = 100;
    
    @State private var screen: String = "wilderness"
    
    @State private var favoritePokemon = PokeUtils.PokemonTeamData.GetFavoriteOrFirstPokemon() ?? nil
    
    
    func GetScreen() -> AnyView {
        switch screen {
        case "pokedex":
            return AnyView(PokedexView(self))
        case "gyms": break
            // return AnyView(GymsView())
        case "wilderness":
            return AnyView(WildernessView(self))
        case "pokecenter": break
            // return AnyView(PokeCenterView())
        default:
            return AnyView(Text("Hello, world!"))
        }
        return AnyView(Text("Hello, world!"))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack(spacing: 0) {
                    HStack {
                        NavigationLink(destination: PokemonTeamListView()) {
                            WebImage(url: PokeUtils.PokemonData.GetFrontPokemonSprite(id: favoritePokemon?.pokemon.id ?? 1), options: [.progressiveLoad])
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text("\(favoritePokemon!.getNickname())\nLVL. \(favoritePokemon!.level)")
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .frame(maxWidth: headerItemWidth)
                    
                    Text("PokéPlay")
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: headerItemWidth)
                    
                    HStack {
                        Spacer()
                        Text("\(name)\n\(currency) ₽")
                            .font(.caption)
                            .multilineTextAlignment(.trailing)
                        WebImage(url: Bundle.main.url(forResource: "pkmn-\(gender)-still", withExtension: "png")!, options: [.progressiveLoad])
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .frame(maxWidth: headerItemWidth)
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                
                // Main Content
                VStack {
                    GetScreen()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Footer
                Divider()
                
                HStack(spacing: 0) {
                    TabButton(title: "Wilderness", iconName: "leaf.fill", selected: screen == "wilderness")
                        .frame(width: tabButtonWidth)
                        .onTapGesture {
                            screen = "wilderness"
                        }
                    
                    TabButton(title: "Pokédex", iconName: "book.closed.fill", selected: screen == "pokedex")
                        .frame(width: tabButtonWidth)
                        .onTapGesture {
                            screen = "pokedex"
                        }
                    
                    TabButton(title: "Gyms", iconName: "building.2.fill", selected: screen == "gyms")
                        .frame(width: tabButtonWidth)
                        .onTapGesture {
                            screen = "gyms"
                        }
                    
                    TabButton(title: "Poké Center", iconName: "cross.case.fill", selected: screen == "pokecenter")
                        .frame(width: tabButtonWidth)
                        .onTapGesture {
                            screen = "pokecenter"
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
            }
            .onAppear() {
                favoritePokemon = PokeUtils.PokemonTeamData.GetFavoritePokemon() ?? PokeUtils.PokemonTeamData.GetPokemonTeamFromUserDefaults().pokemonList[0]
            }
        }
    }
}

struct TabButton: View {
    var title: String
    var iconName: String
    var selected: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(selected ? .blue : .gray)
            
            Text(title)
                .font(.footnote)
                .lineLimit(1)
                .foregroundColor(selected ? .blue : .gray)
                .multilineTextAlignment(.center)
        }
    }
}


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
