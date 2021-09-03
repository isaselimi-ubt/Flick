//
//  ShoppingCartViewModel.swift
//  Flick
//
//  Created by Isa  Selimi on 12.8.21.
//

import Foundation
import SwiftUI
import Firebase


class ShoppingCartViewModel: ObservableObject {
    
    @ObservedObject var userViewModel = UserViewModel.shared
    @Published var bannerData = [BannerModifier.BannerData]()
    
    func addProductToCart(product: Product) -> () {
        if productIsAlreadyAdded(product: product) {
            showBanner(title: "Check your cart", description: "\(product.name) is already added")
        } else {
            do {
                try userViewModel.updateUserData(dict: [
                    "cart" : FieldValue.arrayUnion([[
                        "id": UUID().uuidString,
                        "productId": product.id,
                        "name": product.brand + " " + product.name,
                        "quantity": 1,
                        "price": product.price,
                        "image": product.image,
                        "cost": product.price
                        
                    ]])
                ], isUpdatingQuantity: false)
                showBanner(title: "Item added", description: "\(product.name) was added to your cart")
            } catch {
                showBanner(title: "Error", description: "Cannot add this item")
            }
        }
    }
    
    func removeCartItem(cartItem: CartItem, isUpdatingCardItemQuantity: Bool) {
        try! userViewModel.updateUserData(dict: [
            "cart" : FieldValue.arrayRemove([cartItem.toDictionary()])
        ], isUpdatingQuantity: isUpdatingCardItemQuantity)
    }
    
    
    func productIsAlreadyAdded(product: Product) -> Bool {
        return userViewModel.user!.cart.first{ cartItem in cartItem.productId == product.id } != nil
    }
    
    func decreaseQuantity(cartItem: CartItem) {
        if cartItem.quantity == 1 {
            removeCartItem(cartItem: cartItem, isUpdatingCardItemQuantity: false)
        } else {
            removeCartItem(cartItem: cartItem, isUpdatingCardItemQuantity: true)
            cartItem.quantity -= 1
            try! userViewModel.updateUserData(dict: [
                "cart" : FieldValue.arrayUnion([cartItem.toDictionary()])
            ], isUpdatingQuantity: true)
        }
    }
    
    func increaseQuantity(cartItem: CartItem) {
        removeCartItem(cartItem: cartItem, isUpdatingCardItemQuantity: true)
        cartItem.quantity += 1
        try! userViewModel.updateUserData(dict: [
            "cart" : FieldValue.arrayUnion([cartItem.toDictionary()])
        ], isUpdatingQuantity: true)
    }
    
    func showBanner(title: String, description: String) {
        bannerData.append(BannerModifier.BannerData(title: title, detail: description))
    }
}
