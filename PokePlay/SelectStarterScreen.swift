//
//  SelectStarterScreen.swift
//  PokePlay
//
//  Created by David Paiva on 08/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct SelectStarterScreen: View {
    @AppStorage("starter") private var starter = 0
    @State private var goingToNextScreen = false
    
    func getImageUrl(id: Int) -> URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png") ?? nil
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select your starter")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 200)
                
                HStack() {
                    VStack() {
                        WebImage(url: getImageUrl(id: 1))
                            .frame(width: 90, height: 50)
                            .padding()
                        Text("Bulbasaur")
                            .font(.title3)
                            .padding(.bottom, 5)
                    }
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: starter == 1 ? 5 : 0)
                    )
                    .frame(width: 120, height: 100)
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        starter = 1
                    }
                    
                    VStack() {
                        WebImage(url: getImageUrl(id: 4))
                            .frame(width: 90, height: 50)
                            .padding()
                        Text("Charmander")
                            .font(.title3)
                            .padding(.bottom, 5)
                    }
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: starter == 4 ? 5 : 0)
                    )
                    .frame(width: 120, height: 100)
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        starter = 4
                    }
                    
                    VStack() {
                        WebImage(url: getImageUrl(id: 7))
                            .frame(width: 90, height: 50)
                            .padding()
                        Text("Squirtle")
                            .font(.title3)
                            .padding(.bottom, 5)
                    }
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: starter == 7 ? 5 : 0)
                    )
                    .frame(width: 120, height: 100)
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        starter = 7
                    }
                    
                }
                .padding()
                
                Button("Start Your Adventure!", action: {
                    if (starter == 0) { }
                    else {
                        self.goingToNextScreen = true
                    }
                })
                .buttonStyle(.borderedProminent)
                .disabled(starter == 0)
                .padding(.top, 200)
                
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
