//
//  ChatViewModel.swift
//  StudyApp
//
//  Created by Elias Ferreira on 13/04/26.
//

import Combine
import Foundation

final class ChatViewModel {
    
    private let service = ChatService()
    
    @Published private(set) var messages: [ChatMessage] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        bind()
        service.connect()
    }
    
    private func bind() {
        service.messagePublisher
            .sink() { [weak self] response in
                guard let self = self else { return }
                
                switch response.type {
                case "INIT":
                    self.messages = response.data ?? []
                    
                case "NEW_MESSAGE":
                    if let new = response.dataSingle {
                        self.messages.append(new)
                    }
                    
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    func sendMessage(_ text: String) {
        service.sendMessage(text)
    }
}
