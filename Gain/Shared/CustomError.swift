//
//  CustomError.swift
//  Gain
//
//  Created by christian on 30/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import Foundation

enum CustomError: LocalizedError {
    case auth(description: String)
    case `default`(description: String? = nil)
    
    var errorDescription: String? {
        switch self {
        
        case .auth(let description):
            return description
        case .default(let description):
            return description ?? "Something went wrong"
        }
    }
}
