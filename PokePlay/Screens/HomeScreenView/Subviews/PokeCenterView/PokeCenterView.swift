//
//  PokeCenterView.swift
//  PokePlay
//
//  Created by David Paiva on 19/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokeCenterView: View {
    @StateObject private var viewModel = PokeCenterViewModel()
    
    init() {
        self.viewModel.parent = nil
    }
    
    init(_ parent: HomeScreenViewModel) {
        self.viewModel.parent = parent
    }
    
    var body: some View {
        VStack {
            Text("Heal your Pokémon team\nif they're low on\nhealth points!")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
            
            Spacer()
            
            WebImage(url: viewModel.GetHealingImage()!, options: [.progressiveLoad])
                .resizable()
                .frame(width: 262, height: 200)
            
            Spacer()
            
            Button(viewModel.healing ? "Healing..." : "Heal your Pokémons") {
                viewModel.StartHealing()
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.healing)
            .padding(.bottom, 30)
            .onReceive(viewModel.timer) { _ in
                if (viewModel.healing) {
                    if viewModel.timeRemaining > 0 {
                        viewModel.timeRemaining -= 1
                    } else {
                        if viewModel.timeRemaining > 0 {
                            viewModel.timeRemaining -= 1
                        } else {
                            viewModel.Heal()
                        }
                        viewModel.timer.upstream.connect().cancel()
                    }
                }
            }
        }
    }
}

struct PokeCenterView_Previews: PreviewProvider {
    static var previews: some View {
        PokeCenterView()
    }
}
