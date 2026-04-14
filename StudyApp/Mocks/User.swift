//
//  User.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import Foundation

nonisolated struct User: Hashable, Sendable {
    let id: UUID
    let name: String
}
