//
//  LandingViewModel.swift
//  Gain
//
//  Created by christian on 31/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import Foundation

final class LandingViewModel: ObservableObject {
    @Published var loginSignUpPushed = false
    @Published var createPushed = false
    
    let title = "No Pain, No Gain"
    let createButtonTitle = "Create a challenge"
    let createButtonImageName = "plus.circle"
    let alreadyButtonTitle = "I already have an account"
    let backgroundImageName = "pullup"
}
