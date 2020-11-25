//
//  SettingsViewModel.swift
//  Gain
//
//  Created by christian on 31/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import SwiftUI
import Combine

final class SettingsViewModel: ObservableObject {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Published private(set) var itemViewModels: [SettingsItemViewModel] = []
    @Published var loginSignupPushed = false
    
    let title = "Settings"
    private let userServices: UserServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    init(userServices: UserServiceProtocol  = UserService()) {
        self.userServices = userServices
    }
    
    func item(at index: Int) -> SettingsItemViewModel {
        itemViewModels[index]
    }
    
    func tappedItem(at index: Int) {
        switch itemViewModels[index].type {
        case .account:
            guard userServices.currentUser?.email == nil else { return }
            loginSignupPushed = true
        case .mode:
            // change to light to dark mode
            isDarkMode = !isDarkMode
            buildItem()
        case .privacy:
            print("privacy")
        case .logout:
            userServices.logout().sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            receiveValue: { _ in }
            .store(in: &cancellables)
        }
    }
    
    private func buildItem() {
        itemViewModels = [
            .init(titel: userServices.currentUser?.email ?? "Create Account", iconName: "person.circle", type: .account),
            .init(titel: "Switch to \(isDarkMode ? "Light" : "Dark") Mode", iconName: "lightbulb", type: .mode),
            .init(titel: "Privacy Policy", iconName: "shield", type: .privacy)
        ]
        
        if userServices.currentUser?.email != nil {
            itemViewModels += [.init(titel: "Logout", iconName: "arrowshape.turn.up.left", type: .logout)]
        }
    }
    
    func onAppear() {
        buildItem()
        loginSignupPushed = false
    }
}
