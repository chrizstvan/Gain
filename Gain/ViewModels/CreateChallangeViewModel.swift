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
    
    private let userService: UserServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    enum Action {
        case createChallenge
    }
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func send(action: Action) {
        switch action {
        case .createChallenge:
            currentUserId().sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    print("completed")
                }
            }, receiveValue: { userId in
                print("retrieved userId: \(userId)")
            })
            .store(in: &cancellables)
        }
    }
    
    // Fetch Service
    private func currentUserId() -> AnyPublisher<UserId, Error> {
        print("getting user id")
        return userService.currentUser()
            .setFailureType(to: Error.self)
            .flatMap { user -> AnyPublisher<UserId, Error> in
                if let usedId = user?.uid {
                    print("user is logged in...")
                    
                    return Just(usedId)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } else {
                    print("user is eing logged ini anonymously..")
                    
                    return self.userService
                        .signInAnonymously()
                        .map{ $0.uid }
                        .eraseToAnyPublisher()
                }
        }
        .eraseToAnyPublisher()
    }
}

extension CreateChallangeViewModel {
    struct ChallangePartViewModel: DropdownItemProtocol {
        var selectedOption: DropdownOption
        
        var option: [DropdownOption]
         
        var headerTitle: String {
            return type.rawValue
        }
        
        var dropdownTitle: String {
            selectedOption.formatedValue
        }
        
        var isSelected: Bool = false
        
        private let type: ChallangePartType
        
        init(type: ChallangePartType) {
            switch type {
                
            case .exercise:
                self.option = ExerciseOption.allCases.map{ $0.toDropdownOption }
            case .startAmount:
                self.option = StartOption.allCases.map{ $0.toDropdownOption }
            case .increase:
                self.option = IncreaseOption.allCases.map{ $0.toDropdownOption }
            case .length:
                self.option = LengthOption.allCases.map{ $0.toDropdownOption }
            }
            
            self.type = type
            self.selectedOption = option.first!
        }
        
        enum ChallangePartType: String, CaseIterable {
            case exercise = "Exercise"
            case startAmount = "Starting Amount"
            case increase = "Daily Increase"
            case length = "Challenge Length"
        }
        
        //Dropdown Item - 1
        enum ExerciseOption: String, CaseIterable, DropdownOptionProtocol {
            case pullups
            case pushups
            case situps
            
            var toDropdownOption: DropdownOption {
                .init(
                    type: .text(rawValue),
                    formatedValue: rawValue.capitalized
                )
            }
        }
        
        //Dropdown Item - 2
        enum StartOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
                        
            var toDropdownOption: DropdownOption {
                .init(
                    type: .number(rawValue),
                    formatedValue: "\(rawValue)"
                )
            }
        }
        
        //Dropdown Item - 3
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
                        
            var toDropdownOption: DropdownOption {
                .init(
                    type: .number(rawValue),
                    formatedValue: "+\(rawValue)"
                )
            }
        }
        
        //Dropdown Item - 4
        enum LengthOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
                        
            var toDropdownOption: DropdownOption {
                .init(
                    type: .number(rawValue),
                    formatedValue: "\(rawValue) days"
                )
            }
        }
    }
}

protocol DropdownItemProtocol {
    var option: [DropdownOption] { get }
    var headerTitle: String { get }
    var dropdownTitle: String { get }
    var isSelected: Bool { get set }
    var selectedOption: DropdownOption { get set }
}

struct DropdownOption {
    enum DropdownItemType {
        case text(String)
        case number(Int)
    }
    let type: DropdownItemType
    let formatedValue: String
}

protocol DropdownOptionProtocol {
    var toDropdownOption: DropdownOption { get }
}
