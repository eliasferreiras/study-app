//
//  ConcurrencyViewModel.swift
//  StudyApp
//
//  Created by Elias Ferreira on 13/04/26.
//

import Foundation

@MainActor
final class ConcurrencyViewModel {
    
    private let service: UserServiceProtocol
    
    private(set) var users: [User] = []
    
    init(service: UserServiceProtocol) {
        self.service = service
    }
    
    // Binding simple (UIKit)
    var onUsersUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    func fetchUsers() {
        Task {
            do {
                let users = try await self.service.fetchUsers()
                self.users = users
                onUsersUpdated?()
            } catch {
                onError?(error)
            }
        }
    }
}
