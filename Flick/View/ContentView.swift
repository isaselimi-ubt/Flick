//
//  ContentView.swift
//  Flick
//
//  Created by Isa  Selimi on 11.8.21.
//

import SwiftUI
import Kingfisher


struct ContentView: View {
    
    @StateObject var viewModel = AuthViewModel.shared
    
    init() {
        customizeNavigationBar()
    }
    
    var body: some View {
        
        Group {
            if viewModel.userSession != nil {
                ProductsView()
                
            } else {
                AuthenticationView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.edgesIgnoringSafeArea(.all))
                    .transition(.move(edge: .leading))
            }
        }
        .environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


