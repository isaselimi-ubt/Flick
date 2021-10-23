//
//  UserViewModel.swift
//  Flick
//
//  Created by Isa  Selimi on 14.8.21.
//

import Foundation
import Firebase

class UserViewModel: ObservableObject {
    
    var authViewModel: AuthViewModel = AuthViewModel.shared
    static var shared: UserViewModel = UserViewModel()
    
    static var listenerRegistration: ListenerRegistration?
    var isChangingCartItemQuantity = false
    
    var user: User? {
        willSet {
            if !isChangingCartItemQuantity {
                objectWillChange.send()
            }
        }
    }
    
    var totalPriceOfUserCart = 0.0 {
        willSet {
            if !isChangingCartItemQuantity {
                objectWillChange.send()
            }
        }
    }
    
    init() {
        fetchUser()
    }
    
    func fetchUser() {
        
        guard let uid = authViewModel.userSession?.uid else { return }
        
        UserViewModel.listenerRegistration =
            COLLECTION_USERS.document(uid).addSnapshotListener { (snapshot, _) in
            guard let data = snapshot?.data() else { return }
            self.user = User(dictionary: data)
            self.changeCartTotalPrice()
            self.isChangingCartItemQuantity = false
            // print("DEBUG: User is " + self.user!.username)
        }
    }
    
    func updateUserData(dict: [String : Any], isUpdatingQuantity: Bool) throws {
        isChangingCartItemQuantity = isUpdatingQuantity
        COLLECTION_USERS.document(authViewModel.userSession!.uid).updateData(dict)
    }
    
    func changeCartTotalPrice(){
        totalPriceOfUserCart = 0
        if !user!.cart.isEmpty {
            user!.cart.forEach {
                cartItem in
                totalPriceOfUserCart += cartItem.cost
            }
        }
    }
}
