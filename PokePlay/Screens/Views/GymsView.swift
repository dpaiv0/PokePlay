//
//  GymsView.swift
//  PokePlay
//
//  Created by David Paiva on 26/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct GymsView: View {
    @State var parent: HomeScreen? = nil
    
    @State private var isActive = false
    
    init() {
        self.parent = nil
    }
    
    init(_ parent: HomeScreen) {
        self.parent = parent
    }
    
    func IsGymUnlocked(_ gym: Gym) -> Bool {
        if (gym.name == "Pewter City Gym") {
            return true
        }
        
        if (BadgeUtils.HasBadge(badge: gym.badge)) {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Gyms")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 30)
                
                Spacer()
                
                ScrollView {
                    ForEach(KantoGyms.gyms, id: \.name) { gym in
                        NavigationLink(destination: HomeScreen()) {
                            GymCardSmall(gym, isUnlocked: IsGymUnlocked(gym))
                        }
                        .disabled(!IsGymUnlocked(gym))
                    }
                }
            }
        }
    }
}

struct GymsView_Previews: PreviewProvider {
    static var previews: some View {
        GymsView()
    }
}
