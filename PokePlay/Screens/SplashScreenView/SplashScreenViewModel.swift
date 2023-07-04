//
//  SplashScreenViewModel.swift
//  PokePlay
//
//  Created by David Paiva on 30/06/2023.
//

import Foundation

final class SplashScreenViewModel : ObservableObject {
    @Published var jumpToStarting = false
    @Published var jumpToHome = false
    @Published var timeRemaining = 2
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
}
