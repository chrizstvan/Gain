//
//  LoginSignUpView.swift
//  Gain
//
//  Created by christian on 31/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import SwiftUI

struct LoginSignUpView: View {
    @ObservedObject var viewModel: LoginSignUpViewModel
    
    var emailTextField: some View {
        TextField("Email", text: $viewModel.emailText )
            .modifier(TextFieldCustomRoundedStyle())
    }
    
    var passswordTextField: some View {
        SecureField("Password", text: $viewModel.passwordText )
            .modifier(TextFieldCustomRoundedStyle())
    }
    
    var actionButton: some View {
        Button(viewModel.buttonTitle) {
            //action
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(Color(.systemPink))
        .cornerRadius(16)
        .padding()
    }
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(viewModel.subtitle)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(Color(.systemGray2))
            
            Spacer()
                .frame(height: 50)
            
            emailTextField
            
            passswordTextField
            
            actionButton
            
            Spacer()
        }
    }
}

struct LoginSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSignUpView(viewModel: .init(mode: .login))
    }
}
