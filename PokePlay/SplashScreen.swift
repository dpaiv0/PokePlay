//
//  ContentView.swift
//  PokePlay
//
//  Created by David Paiva on 07/06/2023.
//

import SwiftUI

struct SplashScreen: View {
    @State private var jump = false
    @State var timeRemaining = 2
    
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
                            jump = true
                            timer.upstream.connect().cancel()
                        }
                    }
            }
            .padding()
            
            NavigationLink("", destination: StartingScreen().toolbar(.hidden), isActive: $jump)
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
