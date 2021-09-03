//
//  User.swift
//  Flick
//
//  Created by Isa  Selimi on 11.8.21.
//
import Foundation
import Firebase

struct User: Identifiable {
    
    let id: String
    let name: String
    let email: String
    let cart: [CartItem]
    
    init(dictionary: [String: Any]) {

        self.id = dictionary["id"] as! String
        self.name = dictionary["name"] as! String
        self.email = dictionary["email"] as! String
        self.cart = User.convertCartItems(cartArray: dictionary["cart"] as? [[String: Any]] ?? [])
    }
    
    static func convertCartItems(cartArray: Array<[String: Any]>) -> [CartItem]{
        var cartItems = [CartItem]()
        for cartItem in cartArray {
            cartItems.append(CartItem.init(dictionary: cartItem))
        }
        return cartItems.sorted {
            $0.id < $1.id
        }
    }
}
