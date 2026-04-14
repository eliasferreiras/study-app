//
//  NotCombineViewController.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import UIKit

class NotCombineViewController: UIViewController {
    var current = 0;
    
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Increment", for: .normal)
        button.addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc
    func onTap(_ sender: Any) {
        current += 1
        label.text = "\(current)"
    }
}

extension NotCombineViewController: ViewCode {
    func setupViews() {
        view.backgroundColor = .systemBackground
    }
    
    func setupHierachy() {
        view.addSubview(label)
        view.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Label
            label.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // Button
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
