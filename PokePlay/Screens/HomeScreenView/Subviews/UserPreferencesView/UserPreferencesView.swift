//
//  UserPreferencesView.swift
//  PokePlay
//
//  Created by David Paiva on 30/06/2023.
//

import SwiftUI

struct UserPreferencesView: View {
    @StateObject private var viewModel = UserPreferencesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SplashScreenView().navigationBarHidden(true), isActive: $viewModel.goToStartingScreen) { EmptyView() }
                
                Text("User Preferences")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 30)
                
                Spacer()
                
                List {
                    Toggle("Display Badges instead of Gym Leaders", isOn: $viewModel.renderBadges)
                        .onChange(of: viewModel.renderBadges) { value in
                            SettingsUtils.SetSetting(key: "render_badges", value: viewModel.renderBadges)
                        }
                    
                    Text("Clear Data")
                        .foregroundColor(.red)
                        .onTapGesture {
                            viewModel.clearDataAlert.toggle()
                        }
                }
                .alert(isPresented: $viewModel.clearDataAlert) {
                    Alert(title: Text("Clear Data"), message: Text("Are you sure you want to clear all data?"), primaryButton: .destructive(Text("Yes"), action: {
                        SettingsUtils.ClearData()
                        self.viewModel.goToStartingScreen = true
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
