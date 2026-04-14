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
