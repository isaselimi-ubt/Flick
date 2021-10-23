//
//  AuthViewModel.swift
//  Flick
//
//  Created by Isa  Selimi on 11.8.21.
//


import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var bannerData = [BannerModifier.BannerData]()
    @Published var showProgressView = false
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
    }
    
    func login(email: String, password: String) {
        showProgressView = true
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.showProgressView = false
            if error != nil {
                self.showBanner(title: "Error", description: "Failed to log in")
                return
            }
            withAnimation {
                self.userSession = result?.user
                self.objectWillChange.send()
                UserViewModel.shared.fetchUser()
            }
        }
    }
    
    func registerUser(email: String, password: String, name: String) {
        showProgressView = true
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            self.showProgressView = false
            if let error = error {
                print("DEBUG: Error " + error.localizedDescription)
                self.showBanner(title: "Error", description: "Could not register")
                return
            }
            
            guard let user = result?.user else {
                self.showBanner(title: "Error", description: "Could not get current user")
                return
                
            }
            
            self.uploadUserData(email: email, name: name, userId: user.uid, result: result!)
        }
    }
    
    func uploadUserData(email: String, name: String, userId: String, result: AuthDataResult) {
        
        let data = ["id": userId, "email" : email, "name" : name, "cart" : []] as [String : Any]
       
        COLLECTION_USERS.document(userId).setData(data as [String : Any]) { (error) in
            if error != nil {
                self.showBanner(title: "Error", description: "Could not save user data")
                return
            }
            self.userSession = result.user
            UserViewModel.shared.fetchUser()
        }
    }
    
    func logOut() {
        do {
            try  Auth.auth().signOut()
            withAnimation {
                userSession = nil
                UserViewModel.shared.user = nil
            }
            UserViewModel.listenerRegistration = nil
        } catch {
            print("DEBUG: Could not log out")
        }
    }
    
    func showBanner(title: String, description: String) {
        bannerData.append(BannerModifier.BannerData(title: title, detail: description))
    }
}
