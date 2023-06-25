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
    @State private var showingEditAlert = false
    @State private var showingDeleteAlert = false
    @State private var showingFavoriteAlert = false
    
    @State private var cannotDeleteLastPokemonAlert = false
    
    @State private var pokemonNickname = ""
    @State private var selectedPokemon: ComplexPokemon? = nil
    
    @State private var pokemonTeam = PokeUtils.PokemonTeamData.GetPokemonTeamFromUserDefaults()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Team")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                
                List {
                    ForEach(pokemonTeam.pokemonList, id: \.pokemon.id) { pokemon in
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
                                showingDeleteAlert.toggle()
                                selectedPokemon = pokemon
                            } label: {
                                Label("Release", systemImage: "leaf")
                            }
                            
                            Button {
                                selectedPokemon = pokemon
                                FavoritePokemon()
                            } label: {
                                Label(pokemon.isFavorite() ? "Unfavorite" : "Favorite", systemImage: pokemon.isFavorite() ? "star.slash" : "star")
                            }
                            .tint(Color.yellow)
                            
                            Button {
                                showingEditAlert.toggle()
                                selectedPokemon = pokemon
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(Color.green)
                        }
                        .confirmationDialog("Are you sure you want to release \(pokemon.getNickname())?", isPresented: $showingDeleteAlert) {
                            Button("Release", role: .destructive) {
                                DeletePokemon()
                            }
                        } message:
                        {
                            Text("Are you sure you want to release \(pokemon.getNickname())?")
                        }
                    }
                    .alert("Edit \(selectedPokemon?.getNickname() ?? "Pokémon")'s nickname", isPresented: $showingEditAlert) {
                        
                        TextField("Nickname", text: $pokemonNickname)
                            .onReceive(Just(pokemonNickname)) { _ in limitText(15) }
                        Button("Submit") {
                            EditNickname()
                        }
                    }
                    .alert(isPresented: $cannotDeleteLastPokemonAlert,
                           content: { self.CantDeletePokemon() })
                }
                .onAppear() {
                    pokemonTeam = PokeUtils.PokemonTeamData.GetPokemonTeamFromUserDefaults()
                }
            }
        }
    }
    
    func EditNickname()
    {
        if
            var pokemon = selectedPokemon
        {
            pokemon.setNickname(nickname: pokemonNickname)
            pokemonTeam = PokeUtils.PokemonTeamData.UpdatePokemonFromTeam(pokemon: pokemon)
            
            pokemonNickname = ""
            print(pokemonTeam)
        }
    }
    
    
    func DeletePokemon() {
        
        if
            let pokemon = selectedPokemon
        {
            if PokeUtils.PokemonTeamData.GetPokemonTeamCount() == 1 {
                cannotDeleteLastPokemonAlert.toggle()
                return
            }
            
            pokemonTeam = PokeUtils.PokemonTeamData.RemovePokemonFromTeam(pokemon: pokemon)
        }
    }
    
    func CantDeletePokemon() -> Alert {
        if let pokemon = selectedPokemon {
            return Alert(title: Text("Can't release \(pokemon.getNickname())"), message: Text("You can't release your last Pokémon"), dismissButton: .default(Text("Got it!")))
        }
        
        return Alert(title: Text("Can't release Pokémon"), message: Text("You can't release your last Pokémon"), dismissButton: .default(Text("Got it!")))
        }
    
    
    func FavoritePokemon() {
        if
            let pokemon = selectedPokemon
        {
            
            pokemonTeam = PokeUtils.PokemonTeamData.SetFavoritePokemon(pokemon: pokemon)
        }
    }
    
    func limitText(_ upper: Int) {
        if pokemonNickname.count > upper {
            pokemonNickname = String(pokemonNickname.prefix(upper))
        }
    }
}


struct PokemonTeamListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTeamListView()
    }
}
