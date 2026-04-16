//
//  Feature.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import UIKit

struct Feature {
    let title: String
    let makeViewController: () -> UIViewController
    
    init(title: String, makeViewController: @escaping () -> UIViewController) {
        self.title = title
        self.makeViewController = makeViewController
    }
    
    init<T: UIViewController>(title: String, type: T.Type) {
        self.title = title
        self.makeViewController = {
            let vc = T()
            vc.title = title
            return vc
        }
    }
}

// MARK: - Mock.
extension Feature {
    static var mock: [Feature] {
        [
            .init(title: "Bindable", type: StateViewController.self),
            .init(title: "Combine", type: CombineTabBarController.self),
            .init(title: "Combine Example", type: UserViewController.self),
            .init(title: "Diffable Data Source", type: UserListViewController.self),
            .init(title: "Swift Concurrency", type: ConcurrencyViewController.self),
            .init(title: "Chat", type: ChatViewController.self),
            .init(title: "Lottie", type: LottieViewController.self)
        ]
    }
}
