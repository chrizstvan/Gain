//
//  Dropdowns.swift
//  Gain
//
//  Created by Chris Stev on 28/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import Foundation

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
