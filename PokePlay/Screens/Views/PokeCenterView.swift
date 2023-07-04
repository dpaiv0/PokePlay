//
//  PokeCenterView.swift
//  PokePlay
//
//  Created by David Paiva on 19/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokeCenterView: View {
    
    @State private var healing = false
    @State private var parent: HomeScreenViewModel?
    
    init() {
        self.parent = nil
    }
    
    init(_ parent: HomeScreenViewModel) {
        self.parent = parent
    }
    
    func GetHealingImage() -> URL? {
        if (healing) {
            return Bundle.main.url(forResource: "poke-center-healing", withExtension: "gif")
        } else {
            return Bundle.main.url(forResource: "poke-center-healing-still", withExtension: "png")
        }
    }
    
    @State var timeRemaining = 8
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func StartHealing() -> Void {
        healing = true
    }
    
    var body: some View {
        VStack {
            Text("Heal your Pokémon team\nif they're low on\nhealth points!")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
            
            Spacer()
            
            WebImage(url: GetHealingImage()!, options: [.progressiveLoad])
                .resizable()
                .frame(width: 262, height: 200)
            
            Spacer()
            
            Button(healing ? "Healing..." : "Heal your Pokémons") {
                StartHealing()
            }
            .buttonStyle(.borderedProminent)
            .disabled(healing)
            .padding(.bottom, 30)
            .onReceive(timer) { _ in
                if (healing) {
                    print(timeRemaining)
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        } else {
                            healing = false
                            timer.upstream.connect().cancel()
                            
                            PokeUtils.PokemonTeamData.HealPokemonTeam()
                        }
                        timer.upstream.connect().cancel()
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
