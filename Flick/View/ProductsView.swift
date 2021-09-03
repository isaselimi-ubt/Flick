//
//  ProductsView.swift
//  Flick
//
//  Created by Isa  Selimi on 11.8.21.
//

import SwiftUI

struct ProductsView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var productsViewModel = ProductsViewModel()
    @ObservedObject var shoppingCartViewModel = ShoppingCartViewModel()
    
    @State var showSidebar: Bool = false
    @State private var showingShoppingCart = false
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    let spacing: CGFloat = 10.0
    
    var body: some View {
        SideBarStack(sidebarWidth: UIScreen.screenWidth - 100, showSidebar: $showSidebar) {
            SideMenuContent()
        } content: {
            NavigationView {
                ScrollView(showsIndicators: false) {
                    ScrollViewReader {
                        proxy in
                        LazyVGrid(columns: columns, spacing: spacing) {
                            ForEach(productsViewModel.products, id: \.id) {
                                product in
                                SingleProductView(shoppingCartViewModel: shoppingCartViewModel, product: product)
                            }
                        }.sheet(isPresented: $showingShoppingCart) {
                            ShoppingCartView().environmentObject(authViewModel)
                        }
                        .padding([.horizontal, .top], 10)
                        .navigationTitle("Flick")
                        .navigationBarItems(
                            leading: Button(action: {showSidebar.toggle()}, label: {
                                Image(systemName: "line.horizontal.3")
                            }), trailing: Button(action: {
                                showingShoppingCart.toggle()
                            }, label: {
                                Image(systemName: "cart.fill")
                            }))
                        .navigationBarTitleDisplayMode(.inline)
                        .foregroundColor(.black)
                    }
                }
            }
        }
        .banner(data: $shoppingCartViewModel.bannerData)
    }
}

//struct ProductsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductsView()
//    }
//}
