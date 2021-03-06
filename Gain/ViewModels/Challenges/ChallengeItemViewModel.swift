//
//  ChallengeItemViewModel.swift
//  Gain
//
//  Created by christian on 30/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import Foundation

struct ChallengeItemViewModel: Identifiable {
    private let challenge: Challange
    
    var id: String {
        challenge.id!
    }
    
    var title: String {
        challenge.exercise.capitalized
    }
    
    var progressCircleVM: ProgressCircleViewModel {
        let dayNumber = daysFromStart + 1
        let title = "Day"
        let message = isComplete ? "Done" : "\(dayNumber) of \(challenge.length)"
        
        return .init(
            title: title,
            message: message,
            percentageComplete: Double(dayNumber) / Double(challenge.length)
        )
    }
    
    var daysFromStart: Int {
        let startDate = Calendar.current.startOfDay(for: challenge.startDate)
        let toDate = Calendar.current.startOfDay(for: Date())
        guard let daysFromStart = Calendar.current.dateComponents(
            [.day],
                from: startDate,
                to: toDate
        ).day else {
            return 0
        }
        
        return abs(daysFromStart)
    }
    
    private var isComplete: Bool {
        daysFromStart - challenge.length >= 0
    }
    
    var statusText: String {
        guard !isComplete else { return "Done" }
        let dayNumber = daysFromStart + 1
        return "Day \(dayNumber) of \(challenge.length)"
    }
    
    var dailyIncreaseText: String {
        "+\(challenge.increase) daily"
    }
    
    private let onDelete: (String) -> Void
    
    init(_ challenge: Challange, onDelete: @escaping (String) -> Void) {
        self.challenge = challenge
        self.onDelete = onDelete
    }
    
    func tappedDelete() {
        if let id = challenge.id {
            onDelete(id)
        }
    }
}
