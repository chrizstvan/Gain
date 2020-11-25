//
//  SettingsItemViewModel.swift
//  Gain
//
//  Created by christian on 31/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import Foundation

struct SettingsItemViewModel {
    let titel: String
    let iconName: String
    let type: SettingsItemType
}

enum SettingsItemType {
    case account
    case mode
    case privacy
    case logout
}
