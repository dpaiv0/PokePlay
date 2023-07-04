//
//  TabButton.swift
//  PokePlay
//
//  Created by David Paiva on 04/07/2023.
//

import SwiftUI

struct TabButton: View {
    var title: String
    var iconName: String
    var selected: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(selected ? .blue : .gray)
            
            Text(title)
                .font(.footnote)
                .lineLimit(1)
                .foregroundColor(selected ? .blue : .gray)
                .multilineTextAlignment(.center)
        }
    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        TabButton(title: "Test", iconName: "house")
    }
}
