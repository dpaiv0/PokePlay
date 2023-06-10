//
//  ContentView.swift
//  PokePlay
//
//  Created by David Paiva on 07/06/2023.
//

import SwiftUI

struct SplashScreen: View {
    @State private var jumpToStarting = false
    @State private var jumpToHome = false
    @State var timeRemaining = 2
    @AppStorage("starter") private var starter = ""
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
    var body: some View {
        NavigationStack {
            VStack {
                Image("pokeplay-logo")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        } else {
                            if (starter == "") {
                                jumpToStarting = true
                            } else {
                                jumpToHome = true
                            }
                            
                            timer.upstream.connect().cancel()
                        }
                    }
            }
            .padding()
            
            NavigationLink("", destination: StartingScreen().toolbar(.hidden), isActive: $jumpToStarting)
            
            NavigationLink("", destination: HomeScreen().toolbar(.hidden), isActive: $jumpToHome)
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
