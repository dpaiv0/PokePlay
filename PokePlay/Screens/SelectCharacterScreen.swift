//
//  SelectCharacterScreen.swift
//  PokePlay
//
//  Created by David Paiva on 08/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct SelectCharacterScreen: View {
    @State private var goingToNextScreen = false
    @State private var genders = ["Male", "Female"]
    @AppStorage("name") private var name = ""
    @AppStorage("gender") private var gender = "male"
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: SelectStarterScreen().toolbar(.hidden), isActive: $goingToNextScreen) { EmptyView() }
                
                Text("Select your character")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 150.0)
                
                AnimatedImage(url: Bundle.main.url(forResource: "pkmn-\(gender)", withExtension: "gif")!, options: [.progressiveLoad])
                    .frame(width: 200, height: 200, alignment: .center)
                    .foregroundColor(.accentColor)
                
                Form {
                    Picker("Gender", selection: $gender) {
                        ForEach(genders, id: \.self.localizedLowercase) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("Name", text: $name)
                        .autocorrectionDisabled(true)
                }
                .foregroundColor(.accentColor)
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                
                
                Button("Select Your Starter", action: {
                    if (name.isEmpty) { }
                    else {
                        self.goingToNextScreen = true
                    }
                })
                .buttonStyle(.borderedProminent)
                .disabled(name.isEmpty)
            }
            
        }
        .padding()
    }
}


struct SelectCharacterScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectCharacterScreen()
    }
}