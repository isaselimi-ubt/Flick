//
//  SideMenuContent.swift
//  Flick
//
//  Created by Isa  Selimi on 11.8.21.
//

import SwiftUI

struct SideMenuContent: View {
    
    @ObservedObject var userViewModel = UserViewModel.shared
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 3) {
                    Spacer()
                    if userViewModel.user != nil {
                        Text(userViewModel.user!.name)
                            .font(.system(size: 15))
                        Text(userViewModel.user!.email)
                            .font(.system(size: 15))
                    } else {
                        Text("Loading personal information...")
                    }
                }
                .padding([.horizontal, .bottom], 20)
                .frame(width: UIScreen.screenWidth - 100, height: 210, alignment: .leading)
                .background(Color(hex: 0x93C572))
                .foregroundColor(.white)
                
                Button(action: {
                    authViewModel.logOut()
                }, label: {
                    HStack {
                        Image(systemName: "arrow.forward.square")
                            .foregroundColor(.gray)
                            .font(.system(size: 20, weight: .semibold))
                        Text("Log out")
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                })
                .padding(.horizontal, 10)
                Spacer()
            }
        }
        .background(Color.white)
        .frame(maxHeight: .infinity)
    }
}

//struct SideMenuContent_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenuContent()
//    }
//}
