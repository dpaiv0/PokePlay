//
//  GymsView.swift
//  PokePlay
//
//  Created by David Paiva on 26/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct GymsView: View {
    @StateObject private var viewModel = GymsViewModel()
    
    init() {
        self.viewModel.parent = nil
    }
    
    init(_ parent: HomeScreenViewModel) {
        self.viewModel.parent = parent
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Gyms")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 30)
                
                Spacer()
                
                ScrollView {
                    ForEach(KantoGyms.gyms, id: \.name) { gym in
                        NavigationLink(destination: HomeScreenView()) {
                            GymCardSmall(gym, isUnlocked: viewModel.IsGymUnlocked(gym))
                        }
                        .disabled(!viewModel.IsGymUnlocked(gym))
                    }
                }
            }
        }
    }
}

struct GymsView_Previews: PreviewProvider {
    static var previews: some View {
        GymsView()
    }
}
