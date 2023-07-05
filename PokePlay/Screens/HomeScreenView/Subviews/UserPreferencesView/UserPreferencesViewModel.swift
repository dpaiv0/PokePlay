//
//  UserPreferencesViewModel.swift
//  PokePlay
//
//  Created by David Paiva on 05/07/2023.
//

import Foundation

final class UserPreferencesViewModel : ObservableObject {
    @Published var renderBadges = SettingsUtils.GetSetting(key: "render_badges") as? Bool ?? true
    @Published var clearDataAlert = false
    @Published var goToStartingScreen = false
}
