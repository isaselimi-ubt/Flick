//
//  Other.swift
//  Flick
//
//  Created by Isa  Selimi on 20.8.21.
//

import SwiftUI

struct Blur: UIViewRepresentable {
    
    var style: UIBlurEffect.Style = .systemUltraThinMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
