//
//  Functions.swift
//  Flick
//
//  Created by Isa  Selimi on 11.8.21.
//

import Foundation
import SwiftUI

func customizeNavigationBar() -> () {
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithOpaqueBackground()
    coloredAppearance.backgroundColor = .white
    coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    coloredAppearance.shadowColor = .clear
    UINavigationBar.appearance().standardAppearance = coloredAppearance
    coloredAppearance.titleTextAttributes = [.font : UIFont.boldSystemFont(ofSize: 25)]
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
}

var mockProduct = Product(dictionary: [
    "id" : "123123",
    "brand" : "LG",
    "image" : "https://firebasestorage.googleapis.com/v0/b/flick-2311d.appspot.com/o/2.jpeg?alt=media&token=31112d59-1f08-4ad1-b418-b6a0c9e48810",
    "name" : "Gram 17 (2021)",
    "price" : "1800.0"
])

var mockCartItem = CartItem(dictionary: [
    "id" : "21212",
    "name" : "Macbook Air M1",
    "image" : "https://firebasestorage.googleapis.com/v0/b/flick-2311d.appspot.com/o/2.jpeg?alt=media&token=31112d59-1f08-4ad1-b418-b6a0c9e48810",
    "quantity": "12",
    "productId" : "121212",
    "price" : "20000",
    "cost" : "2123",
])


