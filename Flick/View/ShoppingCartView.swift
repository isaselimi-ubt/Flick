//
//  ShoppingCartView.swift
//  Flick
//
//  Created by Isa  Selimi on 12.8.21.
//

import SwiftUI

struct ShoppingCartView: View {
    
    @ObservedObject var userViewModel = UserViewModel.shared
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.secondary)
                .frame(width: 30, height: 3)
                .padding(.top, 10)
            NavigationView {
                ZStack(alignment: .bottom) {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 0) {
                            ForEach(userViewModel.user!.cart) { cartItem in
                                SingleCartItemView(cartItem: cartItem)
                            }
                        }
                    }
                    .foregroundColor(.black)
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Pay ($\(userViewModel.totalPriceOfUserCart.clean))")
                            .font(.system(size: 20))
                    })
                    .frame(width: UIScreen.screenWidth - 10, height: 50)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipped()
                    .cornerRadius(15)
                    .shadow(radius: 3)
                    .padding(.bottom, 10)
                }
                .navigationTitle("Shopping Cart")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
