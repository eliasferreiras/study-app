//
//  ChatService.swift
//  StudyApp
//
//  Created by Elias Ferreira on 13/04/26.
//

import Combine
import Foundation

final class ChatService {
    
    private var webSocketTask: URLSessionWebSocketTask?
    private let session = URLSession(configuration: .default)
    
    // Publisher
    let messagePublisher = PassthroughSubject<SocketResponse, Never>()
    
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
                print("Erro WS:", error)
                
            case .success(let message):
                self?.handle(message: message)
                self?.listen()
            }
        }
    }
    
    private func handle(message: URLSessionWebSocketTask.Message) {
        var text: String?
                
        switch message {
        case .string(let str):
            text = str
            
        case .data(let data):
            text = String(data: data, encoding: .utf8)
            
        @unknown default:
            break
        }
        
        guard let json = text, let data = json.data(using: .utf8) else { return }
        
        do {
            let decoded = try JSONDecoder().decode(SocketResponse.self, from: data)
            DispatchQueue.main.async {
                self.messagePublisher.send(decoded)
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
