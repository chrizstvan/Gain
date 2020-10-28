//
//  ChallengeService.swift
//  Gain
//
//  Created by Chris Stev on 28/10/20.
//  Copyright © 2020 chrizstvan. All rights reserved.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ChallengeServiceProtocol {
    func create(_ challenge: Challange) -> AnyPublisher<Void, CustomError>
}

final class ChallengeService: ChallengeServiceProtocol {
    private let db = Firestore.firestore()
    
    func create(_ challenge: Challange) -> AnyPublisher<Void, CustomError> {
        return Future<Void, CustomError> { promise in
            do {
                _ = try self.db.collection("challenges").addDocument(from: challenge) { error in
                    if let error = error {
                        promise(.failure(.default(description: error.localizedDescription)))
                    } else {
                        promise(.success(Void()))
                    }
                }
            } catch {
                promise(.failure(.default()))
            }
        }
        .eraseToAnyPublisher()
    }
    
}
