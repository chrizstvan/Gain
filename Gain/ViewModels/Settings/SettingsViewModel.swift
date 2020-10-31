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
    
    let title = "Settings"
    
    func item(at index: Int) -> SettingsItemViewModel {
        itemViewModels[index]
    }
    
    func tappedItem(at index: Int) {
        switch itemViewModels[index].type {
        case .account:
            print("account")
        case .mode:
            // change to light to dark mode
            isDarkMode = !isDarkMode
            buildItem()
        case .privacy:
            print("privacy")
        }
    }
    
    private func buildItem() {
        itemViewModels = [
            .init(titel: "Create Account", iconName: "person.circle", type: .account),
            .init(titel: "Switch to \(isDarkMode ? "Light" : "Dark") Mode", iconName: "lightbulb", type: .mode),
            .init(titel: "Privacy Policy", iconName: "shield", type: .privacy)
        ]
    }
    
    func onAppear() {
        buildItem()
    }
}
