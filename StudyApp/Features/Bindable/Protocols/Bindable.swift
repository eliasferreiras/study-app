//
//  Bindable.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import Foundation

class Bindable<T> {
    typealias Listener = (T) -> Void
    
    // MARK: - Properties
    var listeners: [Listener] = []
    
    // MARK: - Trigger
    var value: T {
        didSet { listeners.forEach { $0(value) } }
    }
    
    // MARK: - Constructos
    init(_ value: T) {
        self.value = value
    }
    
    // MARK: - Bind
    func bind(_ listener: @escaping Listener) {
        self.listeners.append(listener)
    }
}
