//
//  FlickApp.swift
//  Flick
//
//  Created by Isa  Selimi on 11.8.21.
//

import SwiftUI
import Firebase

@main
struct FlickApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
