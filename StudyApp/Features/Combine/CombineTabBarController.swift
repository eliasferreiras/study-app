//
//  TabBarController.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import UIKit

class CombineTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // First Screen
        let notCombineVC = NotCombineViewController()
        notCombineVC.tabBarItem = UITabBarItem(title: "Traditional", image: nil, tag: 0)
        
        let combineVC = WithCombineViewController()
        combineVC.tabBarItem = UITabBarItem(title: "Combine", image: nil, tag: 1)
        
        let refactoredVC = RefactoredViewController()
        refactoredVC.tabBarItem = UITabBarItem(title: "Refactored", image: nil, tag: 2)
        
        viewControllers = [notCombineVC, combineVC, refactoredVC]
    }
}
