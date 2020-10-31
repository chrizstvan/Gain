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
    @Published private(set) var error: CustomError?
    @Published private(set) var isLoading = false
    
    @Published var showingCreateModal = false
    
    let title = "Challenges"
    
    enum Action {
        case retry, create
    }
    
    init(
        userService: UserServiceProtocol = UserService(),
        challengeSerVice: ChallengeServiceProtocol = ChallengeService()
    ) {
        self.userService = userService
        self.challengeService = challengeSerVice
        observeChallanges()
    }
    
    func send(action: Action) {
        switch action {
        
        case .retry:
            observeChallanges()
        case .create:
            showingCreateModal = true
        }
    }
    
    private func observeChallanges() {
        isLoading = true
        userService.currentUser()
            .compactMap { $0?.uid }
            .flatMap { [weak self] userId -> AnyPublisher<[Challange], CustomError> in
                guard let self = self else {
                    return Fail(error: .default()).eraseToAnyPublisher()
                    
                }
                
                return self.challengeService.observeChallanges(userId: userId)
            }
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                switch completion {
                case .finished:
                    print("challenge fetch finished")
                case .failure(let error):
                    self.error = error
                }
            } receiveValue: { [weak self] challenges in
                guard let self = self else { return }
                self.isLoading = false
                self.error = nil
                self.showingCreateModal = false
                
                self.itemViewModels = challenges.map {
                    .init($0)
                }
            }
            .store(in: &cancellables)

    }
}


