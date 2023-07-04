//
//  SelectCharacterScreenViewModel.swift
//  PokePlay
//
//  Created by David Paiva on 04/07/2023.
//

import Foundation

final class SelectCharacterScreenViewModel : ObservableObject {
    @Published var goingToNextScreen = false
    @Published var genders = ["Male", "Female"]
    @Published var name = ""
    @Published var gender = "male"
    
    func emitSave() {
        SettingsUtils.SetSetting(key: "name", value: name)
        SettingsUtils.SetSetting(key: "gender", value: gender)
        
        goingToNextScreen = true
    }
}
