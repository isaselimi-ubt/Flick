//
//  Product.swift
//  Flick
//
//  Created by Isa  Selimi on 11.8.21.
//

import Foundation
import Firebase

struct Product: Identifiable, Hashable {
    
    let id: String
    let name: String
    let image: String
    let brand: String
    let price: String
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as! String
        self.name = dictionary["name"] as! String
        self.image = dictionary["image"] as! String
        self.brand = dictionary["brand"] as! String
        self.price = dictionary["price"] as! String
    }
}

