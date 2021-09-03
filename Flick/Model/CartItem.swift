//
//  CartItem.swift
//  Flick
//
//  Created by Isa  Selimi on 11.8.21.
//

import Foundation
import Firebase

class CartItem: Identifiable, Codable{
    
    let id: String
    let name: String
    let image: String
    var quantity: Int
    var cost: Double
    let productId: String
    var price: Double
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as! String
        self.name = dictionary["name"] as! String
        self.image = dictionary["image"] as! String
        self.quantity = dictionary["quantity"] as! Int
        self.productId = dictionary["productId"] as! String
        self.price = (dictionary["price"] as! NSString).doubleValue
        self.cost = (dictionary["cost"] as! NSString).doubleValue
    }
    
    func toDictionary() -> [String : Any] {
        var dict = [String : Any]()
        dict["id"] = id
        dict["name"] = name
        dict["image"] = image
        dict["quantity"] = quantity
        dict["productId"] = productId
        dict["price"] = price.description
        dict["cost"] = (price * Double(quantity)).description
        
        return dict
    }
}
