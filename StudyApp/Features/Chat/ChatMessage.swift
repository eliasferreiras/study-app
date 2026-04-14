//
//  ChatMessage.swift
//  StudyApp
//
//  Created by Elias Ferreira on 13/04/26.
//

import Foundation

struct ChatMessage: Codable, Hashable {
    let id: Int
    let text: String
}

struct SocketResponse: Codable {
    let type: String
    let data: [ChatMessage]?
    let dataSingle: ChatMessage?
    
    enum CodingKeys: String, CodingKey {
        case type
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        
        if type == "INIT" {
            data = try container.decode([ChatMessage].self, forKey: .data)
            dataSingle = nil
        } else {
            let message = try container.decode(ChatMessage.self, forKey: .data)
            dataSingle = message
            data = nil
        }
    }
}
