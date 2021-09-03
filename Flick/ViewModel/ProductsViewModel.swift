//
//  ProductsViewModel.swift
//  Flick
//
//  Created by Isa  Selimi on 11.8.21.
//

import Foundation

class ProductsViewModel: ObservableObject {
    
    @Published var products = [Product]()
    
    init() {
        fetchProducts()
    }
    
    func fetchProducts() {
        COLLECTION_PRODUCTS.addSnapshotListener { (snapshot, _) in
            guard let documents = snapshot?.documents else { return }
            self.products = documents.map({ Product(dictionary: $0.data()) })
        }
    }
}
