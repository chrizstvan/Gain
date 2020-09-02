//
//  CreateChallangeViewModel.swift
//  Gain
//
//  Created by Chris Stev on 02/09/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import SwiftUI

final class CreateChallangeViewModel: ObservableObject {
    
    @Published var dropdowns: [ChallangePartViewModel] = [
        .init(type: .exercise),
        .init(type: .startAmount),
        .init(type: .increase),
        .init(type: .length)
    ]
}

extension CreateChallangeViewModel {
    struct ChallangePartViewModel: DropdownItemProtocol {
        
        var option: [DropdownOption]
         
        var headerTitle: String {
            return type.rawValue
        }
        
        var dropdownTitle: String {
            return option.first(where: { $0.isSelected })?.formatedValue ?? ""
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
                .init(type: .text(rawValue),
                      formatedValue: rawValue.capitalized,
                      isSelected: self == .pullups)
            }
        }
        
        //Dropdown Item - 2
        enum StartOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
                        
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                      formatedValue: "\(rawValue)",
                    isSelected: self == .one)
            }
        }
        
        //Dropdown Item - 3
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
                        
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                      formatedValue: "+\(rawValue)",
                    isSelected: self == .one)
            }
        }
        
        //Dropdown Item - 4
        enum LengthOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
                        
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                      formatedValue: "\(rawValue) days",
                    isSelected: self == .seven)
            }
        }
    }
}

protocol DropdownItemProtocol {
    var option: [DropdownOption] { get }
    var headerTitle: String { get }
    var dropdownTitle: String { get }
    var isSelected: Bool { get set }
}

struct DropdownOption {
    enum DropdownItemType {
        case text(String)
        case number(Int)
    }
    let type: DropdownItemType
    let formatedValue: String
    var isSelected: Bool
}

protocol DropdownOptionProtocol {
    var toDropdownOption: DropdownOption { get }
}
