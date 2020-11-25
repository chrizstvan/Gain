//
//  Challange.swift
//  Gain
//
//  Created by Chris Stev on 28/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

struct Challange: Codable {
    @DocumentID var id: String?
    let exercise: String
    let startAmount: Int
    let increase: Int
    let length: Int
    let userId: String
    let startDate: Date
}
