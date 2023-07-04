//
//  SelectCharacterScreen.swift
//  PokePlay
//
//  Created by David Paiva on 08/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct SelectCharacterScreenView: View {
    @StateObject private var viewModel = SelectCharacterScreenViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: SelectStarterScreenView().toolbar(.hidden), isActive: $viewModel.goingToNextScreen) { EmptyView() }
                
                Text("Select your character")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 150.0)
                
                AnimatedImage(url: Bundle.main.url(forResource: "pkmn-\(viewModel.gender)", withExtension: "gif")!, options: [.progressiveLoad])
                    .frame(width: 200, height: 200, alignment: .center)
                    .foregroundColor(.accentColor)
                
                Form {
                    Picker("Gender", selection: $viewModel.gender) {
                        ForEach(viewModel.genders, id: \.self.localizedLowercase) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("Name", text: $viewModel.name)
                        .autocorrectionDisabled(true)
                }
                .foregroundColor(.accentColor)
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                
                
                Button("Select Your Starter", action: {
                    if (viewModel.name.isEmpty) { }
                    else {
                        self.viewModel.emitSave()
                    }
                })
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.name.isEmpty)
            }
            
        }
        .padding()
    }
}


struct SelectCharacterScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectCharacterScreenView()
    }
}
