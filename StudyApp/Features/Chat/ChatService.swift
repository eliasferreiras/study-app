//
//  ChatService.swift
//  StudyApp
//
//  Created by Elias Ferreira on 13/04/26.
//

import Foundation

final class ChatService {
    
    private var webSocketTask: URLSessionWebSocketTask?
    private let session = URLSession(configuration: .default)
    
    var onMessage: ((SocketResponse) -> Void)?
    
    // Conectar WebSocket
    
    func connect() {
        if let url = URL(string: "ws://localhost:3000") {
            webSocketTask = session.webSocketTask(with: url)
            webSocketTask?.resume()
            
            listen()
        }
    }
    
    // Escutar Mensagens
    private func listen() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error WS:", error)
                
            case .success(let message):
                switch message {
                case .string(let text):
                    self?.handle(text: text)
                    default : break
                }
                
                // Continua escutando
                self?.listen()
            }
        }
    }
    
    private func handle(text: String) {
        guard let data = text.data(using: .utf8) else { return }
        
        do {
            let decoded = try JSONDecoder().decode(SocketResponse.self, from: data)
            DispatchQueue.main.async {
                self.onMessage?(decoded)
            }
        } catch {
            print("Erro decode:", error)
        }
    }
    
    // Enviar mensagem via HTTP
    func sendMessage(_ text: String) {
        guard let url = URL(string: "http://localhost:3000/messages") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["text": text]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        session.dataTask(with: request).resume()
    }
}
