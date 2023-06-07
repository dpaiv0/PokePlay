//
//  ContentView.swift
//  PokePlay
//
//  Created by David Paiva on 07/06/2023.
//

import SwiftUI

struct SplashScreen: View {
    @State private var jump = false
    @State var timeRemaining = 5
    
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
                                                // optional stop the timer
                                                timer.upstream.connect().cancel()
                                            }
                                        }
            }
            .padding()
            
            NavigationLink("", destination: StartingScreen().toolbar(.hidden), isActive: $jump)


        }
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
