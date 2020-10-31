//
//  ChallangePartViewModel.swift
//  Gain
//
//  Created by Chris Stev on 28/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import Foundation

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
    
    //MARK:- Enum and its logic
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

extension ChallangePartViewModel {
    var text: String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        return nil
    }
    
    var number: Int? {
        if case let .number(number) = selectedOption.type {
            return number
        }
        return nil
    }
}


