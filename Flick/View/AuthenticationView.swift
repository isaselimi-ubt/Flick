//
//  AuthenticationView.swift
//  Flick
//
//  Created by Isa  Selimi on 11.8.21.
//

import SwiftUI

struct AuthenticationView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State var name = ""
    @State var email =  ""
    @State var password = ""
    @State var isRegistering = false
    
    var body: some View {
        VStack(spacing: 30) {
            Image("flick")
                .resizable()
                .frame(width: 200, height: 100)
                .scaledToFill()
                .padding(.bottom, 15)
            
            VStack(spacing: 10) {
                VStack(spacing: 20) {
                    if isRegistering {
                        CustomTextField(text: $name, placeholder: "Name", imageName: "person.fill", textFieldType: .fullname)
                    }
                    CustomTextField(text: $email, placeholder: "Email", imageName: "envelope.fill", textFieldType: .email)
                    CustomTextField(text: $password, placeholder: "Password", imageName: "key.fill", isSecure: true, textFieldType: .password)
                    Button(action: {
                        !isRegistering ? viewModel.login(email: email, password: password) : viewModel.registerUser(email: email, password: password, name: name)
                    }, label: {
                        if viewModel.showProgressiveView {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                                .font(.system(size: 14).bold())
                                .foregroundColor(.white)
                        } else {
                            Text(!isRegistering ? "Login" : "Register")
                                .font(.title2)
                        }
                    })
                    .frame(width: UIScreen.screenWidth - 70, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipped()
                    .background(Color.black)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                }
                .padding(30)
                .frame(width: UIScreen.screenWidth - 30, height: isRegistering ? 330 : 280)
                .clipped()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 6)
                
                HStack(spacing: 4) {
                    Text(isRegistering ? "Already have an account?" : "Don't have an account?")
                        .foregroundColor(.black)
                    Button(action: {
                        withAnimation {
                            isRegistering.toggle()
                        }
                        
                    }, label: {
                        Text(isRegistering ? "Sign in." : "Create an account.")
                    })
                }
                .font(.system(size: 14))
                .padding(.top, 10)
            }
        }
        .padding(.bottom, 70)
        .banner(data: $viewModel.bannerData)
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
