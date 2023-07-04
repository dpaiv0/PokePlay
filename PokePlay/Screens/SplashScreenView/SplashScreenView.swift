//
//  ContentView.swift
//  PokePlay
//
//  Created by David Paiva on 07/06/2023.
//

import SwiftUI

struct SplashScreenView: View {
    @StateObject private var viewModel = SplashScreenViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("pokeplay-logo")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .onReceive(viewModel.timer) { _ in
                        if viewModel.timeRemaining > 0 {
                            viewModel.timeRemaining -= 1
                        } else {
                            if (PokeUtils.PokemonTeamData.GetPokemonTeamFromUserDefaults().pokemonList.count == 0) {
                                viewModel.jumpToStarting = true
                            } else {
                                viewModel.jumpToHome = true
                            }
                            
                            viewModel.timer.upstream.connect().cancel()
                        }
                    }
            }
            .padding()
            
            NavigationLink("", destination: StartingScreenView().toolbar(.hidden), isActive: $viewModel.jumpToStarting)
            
            NavigationLink("", destination: HomeScreenView().toolbar(.hidden), isActive: $viewModel.jumpToHome)
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
