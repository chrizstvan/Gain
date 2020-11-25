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
    func observeChallanges(userId: UserId) -> AnyPublisher<[Challange], CustomError>
    func delete(_ challengeId: String) -> AnyPublisher<Void, CustomError>
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
    
    func observeChallanges(userId: UserId) -> AnyPublisher<[Challange], CustomError> {
        let query = db.collection("challenges")
            .whereField("userId", isEqualTo: userId)
            .order(by: "startDate", descending: true)
        
        return Publishers.QuerySnapshotPublisher(query: query)
            .flatMap { snapshot -> AnyPublisher<[Challange], CustomError> in
                do {
                    let challenges = try snapshot.documents.compactMap {
                        try $0.data(as: Challange.self)
                    }
                    
                    return Just(challenges)
                        .setFailureType(to: CustomError.self)
                        .eraseToAnyPublisher()
                    
                } catch {
                    return Fail(error: .default(description: "Parsing error"))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func delete(_ challengeId: String) -> AnyPublisher<Void, CustomError> {
        return Future<Void, CustomError> { promise in
            self.db.collection("challenges").document(challengeId).delete { error in
                if let error = error {
                    promise(.failure(.default(description: error.localizedDescription)))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
}
