//
//  UserPreferencesView.swift
//  PokePlay
//
//  Created by David Paiva on 30/06/2023.
//

import SwiftUI

struct UserPreferencesView: View {
    @State private var renderBadges = SettingsUtils.GetSetting(key: "render_badges") as? Bool ?? true
    
    @State private var clearDataAlert = false
    
    @State private var goToStartingScreen = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SplashScreenView().navigationBarHidden(true), isActive: $goToStartingScreen) { EmptyView() }
                
                Text("User Preferences")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 30)
                
                Spacer()
                
                List {
                    Toggle("Display Badges instead of Gym Leaders", isOn: $renderBadges)
                        .onChange(of: renderBadges) { value in
                            SettingsUtils.SetSetting(key: "render_badges", value: renderBadges)
                        }
                    
                    Text("Clear Data")
                        .foregroundColor(.red)
                        .onTapGesture {
                            clearDataAlert.toggle()
                        }
                }
                .alert(isPresented: $clearDataAlert) {
                    Alert(title: Text("Clear Data"), message: Text("Are you sure you want to clear all data?"), primaryButton: .destructive(Text("Yes"), action: {
                        SettingsUtils.ClearData()
                        self.goToStartingScreen = true
                    }), secondaryButton: .cancel())
                }
            }
        }
    }
}

struct UserPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        UserPreferencesView()
    }
}
