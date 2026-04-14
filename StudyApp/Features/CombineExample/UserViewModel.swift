//
//  UserViewModel.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import UIKit
import Combine

class UserViewModel {
    
    // Outputs
    @Published private(set) var users: [User] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: String?
    
    private let service: UserServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(service: UserServiceProtocol) {
        self.service = service
    }
    
    func fetchUsers() {
        isLoading = true
        users = []
        
        service.fetchUsers()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                
                if case let .failure(error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] users in
                self?.users = users
            }
            .store(in: &cancellables)
    }
}
