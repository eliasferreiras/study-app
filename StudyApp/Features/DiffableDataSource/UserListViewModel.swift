//
//  UserListViewModel.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import Foundation
import Combine

class UserListViewModel {
    @Published private(set) var users: [User] = []
    @Published private(set) var isEditing: Bool = false
    
    private let service: UserServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(service: UserServiceProtocol) {
        self.service = service
    }
    
    func fetchUsers() {
        service.fetchUsers()
            .receive(on: RunLoop.main)
            .sink { [weak self] users in
                self?.users = users
            }
            .store(in: &cancellables)
    }
    
    func addUser(_ user: User) {
        users.append(user)
    }
    
    func deleteUser(user: User) {
        users.removeAll { $0.id == user.id }
    }
    
    func toggleEdit() {
        isEditing.toggle()
    }
}
