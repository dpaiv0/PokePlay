//
//  StartingScreen.swift
//  PokePlay
//
//  Created by David Paiva on 07/06/2023.
//

import SwiftUI

struct StartingScreenView: View {
    @StateObject private var viewModel = StartingScreenViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: SelectCharacterScreenView().toolbar(.hidden), isActive: $viewModel.goingToNextScreen) { EmptyView() }
                
                
                Image("pokeplay-logo")
                    .padding(.top, 150.0)
                    .padding(.bottom, 10.0)
                    .imageScale(.medium)
                    .foregroundColor(.accentColor)
                
                Text("Welcome to\nPokéPlay")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("A Pokémon-like game for iOS!")
                    .font(.title2)
                
                NavigationLink(destination: SelectCharacterScreenView().navigationBarHidden(true)) {
                    Button("Get Started", action: {
                        self.viewModel.goingToNextScreen = true
                    })
                    .padding(.top, 250.0)
                    .buttonStyle(.borderedProminent)
                }
                
            }
            .padding()
        }
    }
}

struct StartingScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartingScreenView()
    }
}
