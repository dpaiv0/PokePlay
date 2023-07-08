//
//  GymsDetailView.swift
//  PokePlay
//
//  Created by David Paiva on 08/07/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct GymsDetailView: View {
    @State var gym: Gym
    
    init (_ gym: Gym) {
        self.gym = gym;
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(gym.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                HStack {
                    WebImage(url: gym.gymLeader.GetSprite())
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Type: \(gym.type)")
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                        
                        Text("Badge: \(gym.badge.name)")
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                        
                        Text("Gym Leader: \(gym.gymLeader.name)")
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                    }
                }
                
                Spacer()
                
                Text("\(gym.gymLeader.name)'s Team")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                ScrollView {
                    LazyVStack {
                        ForEach(0..<gym.gymLeader.team.count, id: \.self) { pokemon in
                            PokemonSpriteView(gym.gymLeader.team[pokemon])
                        }
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: PokemonFightView(gym.gymLeader.team, gym).navigationBarBackButtonHidden(true)) {
                    Text("Battle \(gym.gymLeader.name)")
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
    }
}

struct GymsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GymsDetailView(KantoGyms.gyms[0])
    }
}
