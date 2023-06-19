//
//  SelectStarterScreen.swift
//  PokePlay
//
//  Created by David Paiva on 08/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct SelectStarterScreen: View {
    @State private var starter = 0
    @State private var goingToNextScreen = false
    @Environment(\.colorScheme) var colorScheme
    
    private var starters = [1, 4, 7]
    
    var body: some View {
        NavigationStack {
            
            NavigationLink(destination: HomeScreen().toolbar(.hidden), isActive: $goingToNextScreen) {
                EmptyView()
            }
            
            VStack {
                Text("Select your starter")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 200)
                
                HStack() {
                    
                    ForEach(starters, id: \.self) { starter in
                        VStack() {
                            WebImage(url: PokeUtils.PokemonData.GetFrontPokemonSprite(id: starter), options: [.progressiveLoad])
                                .frame(width: 90, height: 50)
                                .padding()
                            Text(PokeUtils.PokemonData.GetPokemonById(id: starter).name.capitalized)
                                .font(.title3)
                                .padding(.bottom, 5)
                        }
                        .foregroundColor(.white)
                        .background(Color(hex: PokeUtils.PokemonData.GetColorForPokemonType(pokemon: PokeUtils.PokemonData.GetPokemonById(id: starter))))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(colorScheme == .dark ? .white : .black, lineWidth: self.starter == starter ? 5 : 0)
                        )
                        .frame(width: 120, height: 100)
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            self.starter = starter
                        }
                    }
                }
                .padding()
                
                Button("Start Your Adventure!", action: {
                    if (starter == 0) { }
                    else {
                        selectStarter()
                        self.goingToNextScreen = true
                    }
                    
                })
                .buttonStyle(.borderedProminent)
                .disabled(starter == 0)
                .padding(.top, 200)
                
            }
            .padding()
        }
    }
    
    func selectStarter() {
        let starterData = PokeUtils.PokemonData.GetPokemonById(id: starter)
        
        PokeUtils.PokedexData.AppendPokemonToPokedex(pokemon: starterData)
        
        PokeUtils.PokemonTeamData.AppendPokemonToTeam(pokemon: ComplexPokemon(pokemon: starterData, level: 5))
        
        PokeUtils.PokemonTeamData.SetFavoritePokemon(pokemon: PokeUtils.PokemonTeamData.GetPokemonTeamFromUserDefaults().pokemonList[0])
    }
}

struct SelectStarterScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectStarterScreen()
    }
}
