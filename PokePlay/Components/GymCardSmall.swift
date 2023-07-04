//
//  GymCardSmall.swift
//  PokePlay
//
//  Created by David Paiva on 26/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct GymCardSmall: View {
    private var gym: Gym
    private var isUnlocked: Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    init(_ gym: Gym, isUnlocked: Bool) {
        self.gym = gym
        self.isUnlocked = isUnlocked
    }
    
    func GetImageUrl() -> URL {
        if (SettingsUtils.GetSetting(key: "render_badges") as! Bool) {
            return gym.badge.GetSprite()
        } else {
            return gym.gymLeader.GetSprite()
        }
    }
    
    var body: some View {
        HStack {
            WebImage(url: GetImageUrl(), options: [.progressiveLoad])
                .resizable()
                .colorMultiply(!isUnlocked ? Color.gray : Color.white)
                .grayscale(!isUnlocked ? 1 : 0)
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(isUnlocked ? gym.name : "????????????")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text("Type: \(isUnlocked ? gym.type : "???????????")")
                    .font(.subheadline)
                
                Text("Leader: \(isUnlocked ? gym.gymLeader.name : "?????????")")
                    .font(.subheadline)
            }
            
            Spacer()
            
            Image(gym.badge.sprite)
                .resizable()
                .frame(width: 50, height: 50)
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

struct GymCardSmall_Previews: PreviewProvider {
    static var previews: some View {
        GymCardSmall(KantoGyms.gyms[0], isUnlocked: true)
    }
}
