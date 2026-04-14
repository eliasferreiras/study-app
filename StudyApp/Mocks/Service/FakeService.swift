//
//  Service.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import UIKit
import Combine

protocol UserServiceProtocol {
    func fetchUsers() -> AnyPublisher<[User], Never>
    func fetchUsers() async throws -> [User]
}

class FakeUserService: UserServiceProtocol {
    func fetchUsers() -> AnyPublisher<[User], Never> {
        return Just(users)
            .delay(for: .seconds(2), scheduler: DispatchQueue.global())
            .eraseToAnyPublisher()
    }
    
    // Swift Concurrency
    func fetchUsers() async throws -> [User] {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        return users
    }
}

extension FakeUserService {
    private var users: [User] {
        return [
            User(id: UUID(), name: "Elias"),
            User(id: UUID(), name: "Maria"),
            User(id: UUID(), name: "João")
        ]
    }
}

