//
//  AnimatedImageView.swift
//  PokePlay
//
//  Created by David Paiva on 08/06/2023.
//

import Foundation
import SwiftUI
import FLAnimatedImage

struct AnimatedImageView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    let animatedView = FLAnimatedImageView()
    var fileName: String
    
    func makeUIView(context: UIViewRepresentableContext<AnimatedImageView>) -> UIView {
        let view = UIView()
        
        // Search a gif file in the bundle inside of folder "Images"        
        let url = Bundle.main.url(forResource: fileName, withExtension: "gif")!
    
        let data = try! Data(contentsOf: url)
        
        let image = FLAnimatedImage(animatedGIFData: data)
    
        animatedView.animatedImage = image
        animatedView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animatedView)
        
        NSLayoutConstraint.activate([
            animatedView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animatedView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    
    }
}
