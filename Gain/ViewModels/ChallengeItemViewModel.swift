//
//  ChallengeItemViewModel.swift
//  Gain
//
//  Created by christian on 30/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import Foundation

struct ChallengeItemViewModel: Hashable {
    private let challenge: Challange
    
    var title: String {
        challenge.exercise.capitalized
    }
    
    var daysFromStart: Int {
        guard let daysFromStart = Calendar.current.dateComponents(
                [.day],
                from: challenge.startDate,
                to: Date()
        ).day else {
            return 0
        }
        
        return abs(daysFromStart)
    }
    
    private var isComplete: Bool {
        daysFromStart - challenge.length > 0
    }
    
    var statusText: String {
        guard !isComplete else { return "Done" }
        let dayNumber = daysFromStart + 1
        return "Day \(dayNumber) of \(challenge.length)"
    }
    
    var dailyIncreaseText: String {
        "+\(challenge.increase) daily"
    }
    
    init(_ challenge: Challange) {
        self.challenge = challenge
    }
}
