//
//  LoginSignUpViewModel.swift
//  Gain
//
//  Created by christian on 31/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import SwiftUI
import Combine

final class LoginSignUpViewModel: ObservableObject {
    private let mode: Mode
    
    @Published var emailText = ""
    @Published var passwordText = ""
    @Published var isValid = false
    @Binding var isPushed: Bool
    private let userService: UserServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    init(
        mode: Mode,
        userService: UserServiceProtocol = UserService(),
        isPushed: Binding<Bool>
    ) {
        self.mode = mode
        self.userService = userService
        self._isPushed = isPushed
        
        Publishers.CombineLatest($emailText, $passwordText)
            .map {[weak self] email, password in
                // if email is valid && password is valid
                return self?.isValidEmail(email) == true
                    && self?.isValidPassword(password) == true
            }
            .assign(to: &$isValid)
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
    
    func tapActionButton() {
        switch mode {
        case .login:
            userService.login(email: emailText, password: passwordText).sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            receiveValue: { _ in}
            .store(in: &cancellables)

        case .signup:
            userService.linkAccount(email: emailText, password: passwordText).sink {[weak self] completion in
                switch completion {
                case .finished:
                    self?.isPushed = false
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
        }
    }
}

extension LoginSignUpViewModel {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email) && email.count > 5
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return password.count > 5
    }
}

extension LoginSignUpViewModel {
    enum Mode {
        case login
        case signup
    }
}
