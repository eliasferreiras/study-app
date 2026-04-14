//
//  ChatViewModel.swift
//  StudyApp
//
//  Created by Elias Ferreira on 13/04/26.
//

import Foundation

final class ChatViewModel {
    
    private let service = ChatService()
    
    private(set) var messages: [ChatMessage] = []
    
    var onUpdate: (() -> Void)?
    
    init() {
        bind()
        service.connect()
    }
    
    private func bind() {
        service.onMessage = { [weak self] response in
            guard let self = self else { return }
            
            switch response.type {
            case "INIT":
                self.messages = response.data ?? []
                
            case "NEW_MESSAGE":
                if let new = response.dataSingle {
                    self.messages.append(new)
                }
                
            default: break
            }
            
            self.onUpdate?()
        }
    }
    
    func sendMessage(_ text: String) {
        service.sendMessage(text)
    }
}
