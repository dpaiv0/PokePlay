//
//  SelectStarterScreen.swift
//  PokePlay
//
//  Created by David Paiva on 08/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct SelectStarterScreenView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel = SelectStarterScreenViewModel()
    
    var body: some View {
        NavigationStack {
            
            NavigationLink(destination: HomeScreenView().toolbar(.hidden), isActive: $viewModel.goingToNextScreen) {
                EmptyView()
            }
            
            VStack {
                Text("Select your starter")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 200)
                
                HStack() {
                    
                    ForEach(viewModel.starters, id: \.self) { starter in
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
                                .stroke(colorScheme == .dark ? .white : .black, lineWidth: self.viewModel.starter == starter ? 5 : 0)
                        )
                        .frame(width: 120, height: 100)
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            self.viewModel.starter = starter
                        }
                    }
                }
                .padding()
                
                Button("Start Your Adventure!", action: {
                    if (viewModel.starter == 0) { }
                    else {
                        viewModel.selectStarter()
                    }
                })
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.starter == 0)
                .padding(.top, 200)
            }
            .padding()
        }
    }
}

struct SelectStarterScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectStarterScreenView()
    }
}
