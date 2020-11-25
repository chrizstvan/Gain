//
//  ProgressCircleViewModel.swift
//  Gain
//
//  Created by christian on 25/11/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import Foundation

struct ProgressCircleViewModel {
    let title: String
    let message: String
    let percentageComplete: Double
    var shouldShowTitle: Bool {
        percentageComplete <= 1
    }
}
