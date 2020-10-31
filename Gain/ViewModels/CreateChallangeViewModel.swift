//
//  CreateChallangeViewModel.swift
//  Gain
//
//  Created by Chris Stev on 02/09/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import SwiftUI
import Combine

typealias UserId = String

final class CreateChallangeViewModel: ObservableObject {
    
    
    @Published var exerciseDropdowns = ChallangePartViewModel(type: .exercise)
    @Published var startAmountDropdowns = ChallangePartViewModel(type: .startAmount)
    @Published var increaseDropdowns = ChallangePartViewModel(type: .increase)
    @Published var lengthDropdowns = ChallangePartViewModel(type: .length)
    
    // observe the error
    @Published var error: CustomError?
    @Published var isLoading = false
    
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    enum Action {
        case createChallenge
    }
    
    init(
        userService: UserServiceProtocol = UserService(),
        challengeService: ChallengeServiceProtocol = ChallengeService()
    ) {
        self.userService = userService
        self.challengeService = challengeService
    }
    
    func send(action: Action) {
        switch action {
        case .createChallenge:
            isLoading = true
            
            currentUserId()
                .flatMap { userId -> AnyPublisher<Void, CustomError> in
                    return self.createChallenge(userId: userId)
                }
                .sink(receiveCompletion: { completion in
                    self.isLoading = false
                    
                    switch completion {
                    case .failure(let error):
                        self.error = error
                    case .finished:
                        break
                }
            }, receiveValue: { _ in
                print("success")
            })
            .store(in: &cancellables)
        }
    }
    
    // post to backend
    private func createChallenge(userId: UserId) -> AnyPublisher<Void, CustomError> {
        guard let exercise = exerciseDropdowns.text,
            let startAmount = startAmountDropdowns.number,
            let increase = increaseDropdowns.number,
            let length = lengthDropdowns.number else {
                return Fail(error: .default(description: "Parsing Error."))
                    .eraseToAnyPublisher()
        }
        
        let chalange = Challange(
            exercise: exercise,
            startAmount: startAmount,
            increase: increase,
            length: length,
            userId: userId,
            startDate: Date()
        )
        
        return challengeService.create(chalange).eraseToAnyPublisher()
    }
    
    
    // Fetch Service
    private func currentUserId() -> AnyPublisher<UserId, CustomError> {
        print("getting user id")

        return userService.currentUser()
            .setFailureType(to: CustomError.self)
            .flatMap { user -> AnyPublisher<UserId, CustomError> in
                if let usedId = user?.uid {
                    print("user is logged in...")

                    return Just(usedId)
                        .setFailureType(to: CustomError.self)
                        .eraseToAnyPublisher()
                } else {
                    print("user is eing logged in anonymously..")

                    return self.userService
                        .signInAnonymously()
                        .map{ $0.uid }
                        .eraseToAnyPublisher()
                }
        }
        .eraseToAnyPublisher()
    }
}


