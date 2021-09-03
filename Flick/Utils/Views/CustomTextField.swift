//
//  CustomTextField.swift
//  Slanter
//
//  Created by Isa  Selimi on 18.1.21.
//

import SwiftUI

enum TextFieldType {
    case email
    case password
    case fullname
    case other
}

struct CustomTextField: View {
    
    @Binding var text: String
    let placeholder: String
    let imageName: String
    var isSecure: Bool = false
    var textFieldType: TextFieldType = .other
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.black.opacity(0.5))
                    .padding(.leading, 40)
            }

            HStack(spacing: 16) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black.opacity(0.5))

                if isSecure {
                    SecureField("", text: $text)
                } else {
                    TextField("", text: $text)
                        .if(textFieldType == .fullname) {
                            $0.autocapitalization(.words)
                        }
                        .if(textFieldType == .email) {
                            $0.keyboardType(.emailAddress).autocapitalization(.none)
                        }
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.3))
        .cornerRadius(30)
    }
}

//struct CustomTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTextField(text: .constant(""), placeholder: "test")
//    }
//}
