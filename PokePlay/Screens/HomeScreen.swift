//
//  HomeScreen.swift
//  PokePlay
//
//  Created by David Paiva on 10/06/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeScreen: View {
    let tabButtonWidth: CGFloat = UIScreen.main.bounds.width / 5
    let headerItemWidth: CGFloat = UIScreen.main.bounds.width / 3
    
    @AppStorage("starter") private var starter = 0;
    @AppStorage("gender") private var gender = "";
    @AppStorage("name") private var name = "";
    @AppStorage("currency") private var currency = 100;
    
    var body: some View {
        VStack {
            // Header
            HStack(spacing: 0) {
                HStack {
                    WebImage(url: PokeUtils.GetFrontPokemonSprite(id: starter), options: [.progressiveLoad])
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("\(PokeUtils.GetPokemonById(id: starter).name.capitalized)\nLVL. 1")
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .frame(maxWidth: headerItemWidth)
                
                Text("PokéPlay")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: headerItemWidth)
                
                HStack {
                    Spacer()
                    Text("\(name)\n\(currency) ₽")
                        .font(.caption)
                        .multilineTextAlignment(.trailing)
                    WebImage(url: Bundle.main.url(forResource: "pkmn-\(gender)-still", withExtension: "png")!, options: [.progressiveLoad])
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .frame(maxWidth: headerItemWidth)
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            
            // Main Content
            VStack {
                Text("Main Content")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Footer
            Divider()
            
            HStack(spacing: 0) {
                TabButton(title: "Pokédex", iconName: "book.closed.fill")
                    .frame(width: tabButtonWidth)
                
                TabButton(title: "Gyms", iconName: "building.2.fill")
                    .frame(width: tabButtonWidth)
                
                TabButton(title: "Wild", iconName: "leaf.fill", selected: true)
                    .frame(width: tabButtonWidth)
                
                TabButton(title: "Shop", iconName: "cart.fill")
                    .frame(width: tabButtonWidth)
                
                TabButton(title: "Bag", iconName: "bag.fill")
                    .frame(width: tabButtonWidth)
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
        }
    }
}

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


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
