//
//  HomeViewModel.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import UIKit

class HomeViewModel {
    // MARK: - Model
    var features = [Feature]()
    
    // MARK: - Funcions
    func fetchFeatures() {
        FeatureService.fetchAll { features in
            self.features = features
        }
    }
    
    // MARK: - Actions
    func navigate(to feature: Feature, from viewController: UIViewController) {
        viewController.navigationController?.pushViewController(
            feature.makeViewController(),
            animated: true
        )
    }
}
