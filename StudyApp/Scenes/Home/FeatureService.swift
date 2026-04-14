//
//  FeatureService.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import Foundation

class FeatureService {
    static func fetchAll(completion: @escaping ([Feature]) -> Void) {
        completion([
            .init(title: "Bindable", type: StateViewController.self),
            .init(title: "Combine", type: CombineTabBarController.self),
            .init(title: "Combine Example", type: UserViewController.self),
            .init(title: "Diffable Data Source", type: UserListViewController.self),
            .init(title: "Swift Concurrency", type: ConcurrencyViewController.self),
            .init(title: "Chat", type: ChatViewController.self)
        ])
    }
}
