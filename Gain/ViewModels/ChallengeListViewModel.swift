//
//  ChallengeListViewModel.swift
//  Gain
//
//  Created by christian on 30/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import Foundation
import Combine

final class ChallengeListViewModel: ObservableObject {
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    @Published private(set) var itemViewModels: [ChallengeItemViewModel] = []
    
    let title = "Challenges"
    
    init(
        userService: UserServiceProtocol = UserService(),
        challengeSerVice: ChallengeServiceProtocol = ChallengeService()
    ) {
        self.userService = userService
        self.challengeService = challengeSerVice
        observeChallanges()
    }
    
    private func observeChallanges() {
        userService.currentUser()
            .compactMap { $0?.uid }
            .flatMap { userId -> AnyPublisher<[Challange], CustomError> in
                return self.challengeService.observeChallanges(userId: userId)
            }
            .sink { completion in
                switch completion {
                case .finished:
                    print("challenge fetch finished")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { challenges in
                self.itemViewModels = challenges.map {
                    .init($0)
                }
            }
            .store(in: &cancellables)

    }
}


