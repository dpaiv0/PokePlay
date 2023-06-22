//
//  WildernessView.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct WildernessView: View {
    var parent: HomeScreen? = nil
    @State private var walking = false;
    
    @State var timeRemaining = 7
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() {
        self.parent = nil
    }
    
    init(_ parent: HomeScreen) {
        self.parent = parent
    }
    
    func StartWalking() -> Void {
        walking = true
        
        let randomInt = Int.random(in: 3..<8)
        
        timeRemaining = randomInt
    }
    
    func GetWalkingImage() -> URL? {
        if (walking) {
            return Bundle.main.url(forResource: "tall-grass-walking", withExtension: "gif")
        } else {
            return Bundle.main.url(forResource: "tall-grass-walking-still", withExtension: "png")
        }
    }
    
    func StartFight() -> Void {
        walking = false
        
        let pokemon = CpuFight.GetRandomPokemon()
        
        let complexPokemon = ComplexPokemon(pokemon: pokemon, level: PokeUtils.PokemonTeamData.GetFavoriteOrFirstPokemon().level)
        
        let fightView = PokemonFightView(complexPokemon)
        
        self.parent?.GoToFightView(fightView)
    }
    
    var body: some View {
        VStack {
            Text("Walk through the\nWilderness to catch\nwild Pokémon!")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
            
            Spacer()
            
            WebImage(url: GetWalkingImage()!, options: [.progressiveLoad])
                .resizable()
                .scaledToFit()
                .frame(width: 275)
            
            
            
            Spacer()
            
            Button(walking ? "Walking..." : "Start Walking") {
                StartWalking()
            }
            .buttonStyle(.borderedProminent)
            .disabled(walking)
            .padding(.bottom, 30)
            .onReceive(timer) { _ in
                if (walking) {
                    print(timeRemaining)
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        } else {
                            print("Time to Fight!")
                            StartFight()
                            timer.upstream.connect().cancel()
                        }
                        timer.upstream.connect().cancel()
                    }
                }
            }
        }
    }
}

struct WildernessView_Previews: PreviewProvider {
    static var previews: some View {
        WildernessView()
    }
}
