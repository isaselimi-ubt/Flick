//
//  SingleProductView.swift
//  Flick
//
//  Created by Isa  Selimi on 11.8.21.
//

import SwiftUI
import Kingfisher

struct SingleProductView: View {
    
    @ObservedObject var shoppingCartViewModel: ShoppingCartViewModel
    
    var product: Product
    
    var body: some View {
        
        VStack {
            KFImage(URL(string: product.image))
                .loadImmediately()
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 170, height: 170)
                .padding(.top)
            
            VStack {
                Text(product.name)
                    .font(.system(size: 17))
                    .bold()
                Text(product.brand)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
            }
            .padding(10)
            
            HStack {
                Text("$\(Double(product.price)!.clean)")
                    .font(.system(size: 19))
                    .bold()
                Spacer()
                Button(action: {
                    shoppingCartViewModel.addProductToCart(product: product)
                }, label: {
                    Image(systemName: "cart.badge.plus")
                        .font(.system(size: 19))
                })
            }
            .foregroundColor(.black)
            .padding([.horizontal, .bottom])
        }
        .clipped()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color(.lightGray).opacity(0.6), radius: 4, x: 2, y: 2)
    }
}

//struct SingleProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleProductView(product: mockProduct)
//    }
//}
