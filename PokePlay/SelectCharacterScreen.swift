//
//  SelectCharacterScreen.swift
//  PokePlay
//
//  Created by David Paiva on 08/06/2023.
//

import SwiftUI

struct SelectCharacterScreen: View {
    @State private var genders = ["Male", "Female"]
    @AppStorage("name") private var name = ""
    @AppStorage("gender") private var gender = "male"
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select your character")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 150.0)
                
                AnimatedImageView(fileName: "pkmn-\(gender)")
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
                            }
                .foregroundColor(.accentColor)
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                
                
                NavigationLink(destination: SelectCharacterScreen().navigationBarHidden(true)) {
                    Button("Get Started", action: {
                        // self.goingToNextScreen = true
                    })
                        // .padding(.top, 250.0)
                        .buttonStyle(.borderedProminent)
                                }
                
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
