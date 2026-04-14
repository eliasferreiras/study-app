//
//  StateService.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import Foundation

class StateService {
    var text: String = "Hello, World!"
    
    func getContent(shouldFail: Bool = false, completion: @escaping (Result<String, Error>) -> Void) {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            if shouldFail {
                completion(.failure(StateError()))
            }
            completion(.success(self.text))
        }
    }
}

struct StateError: LocalizedError {
    var errorDescription: String? { "Error" }
}
