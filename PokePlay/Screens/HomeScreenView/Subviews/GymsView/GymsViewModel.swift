//
//  GymsViewModel.swift
//  PokePlay
//
//  Created by David Paiva on 05/07/2023.
//

import Foundation

final class GymsViewModel : ObservableObject {
    @Published var parent: HomeScreenViewModel? = nil
    @Published var isActive = false
    
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
    
}
