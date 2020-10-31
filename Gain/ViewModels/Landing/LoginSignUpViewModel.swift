//
//  LoginSignUpViewModel.swift
//  Gain
//
//  Created by christian on 31/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import Foundation

final class LoginSignUpViewModel: ObservableObject {
    private let mode: Mode
    
    @Published var emailText = ""
    @Published var passwordText = ""
    @Published var isValid = false
    
    init(mode: Mode) {
        self.mode = mode
    }
    
    var title: String {
        switch mode {
        case .login:
            return "Welcome back!"
        case .signup:
            return " Create an account"
        }
    }
    
    var subtitle: String {
        switch mode {
        case .login:
            return "Login with your email"
        case .signup:
            return "Sign up via email"
        }
    }
    
    var buttonTitle: String {
        switch mode {
        case .login:
            return "Log in"
        case .signup:
            return "Sign up"
        }
    }
}

extension LoginSignUpViewModel {
    enum Mode {
        case login
        case signup
    }
}
