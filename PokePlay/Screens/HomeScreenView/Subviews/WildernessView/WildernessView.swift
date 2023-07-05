//
//  WildernessView.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct WildernessView: View {
    @StateObject private var viewModel = WildernessViewModel()
    
    init() {
        self.viewModel.parent = nil
    }
    
    init(_ parent: HomeScreenViewModel) {
        self.viewModel.parent = parent
    }
    
    var body: some View {
        VStack {
            Text("Walk through the\nWilderness to catch\nwild Pokémon!")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
            
            Spacer()
            
            WebImage(url: viewModel.GetWalkingImage()!, options: [.progressiveLoad])
                .resizable()
                .scaledToFit()
                .frame(width: 275)
            
            Spacer()
            
            Button(viewModel.walking ? "Walking..." : "Start Walking") {
                viewModel.StartWalking()
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.walking)
            .padding(.bottom, 30)
            .onReceive(viewModel.timer) { _ in
                if (viewModel.walking) {
                    if viewModel.timeRemaining > 0 {
                        viewModel.timeRemaining -= 1
                    } else {
                        if viewModel.timeRemaining > 0 {
                            viewModel.timeRemaining -= 1
                        } else {
                            viewModel.StartFight()
                            viewModel.timer.upstream.connect().cancel()
                        }
                        viewModel.timer.upstream.connect().cancel()
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.canNotBattle) {
            Alert(title: Text("You can't battle!"), message: Text("You need to have at least one Pokémon that isn't fainted to battle!"), dismissButton: .default(Text("OK")))
        }
    }
}

struct WildernessView_Previews: PreviewProvider {
    static var previews: some View {
        WildernessView()
    }
}
