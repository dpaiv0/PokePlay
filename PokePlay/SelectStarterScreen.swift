//
//  SelectStarterScreen.swift
//  PokePlay
//
//  Created by David Paiva on 08/06/2023.
//

import SwiftUI

struct SelectStarterScreen: View {
    @AppStorage("starter") private var starter = 0
    
    func getPath() -> Void {
        let poke = PokeUtils.GetPokemonById(id: 1)
        print(poke)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select your starter")
                    .font(.title)
                    .fontWeight(.bold)
                    .onAppear(perform: getPath)
            }
            .padding()
        }
    }
}

struct SelectStarterScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectStarterScreen()
    }
}
