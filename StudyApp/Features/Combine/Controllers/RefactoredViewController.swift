//
//  RefactoredViewController.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import UIKit
import Combine

class RefactoredViewController: UIViewController {
    
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
    
    let counter = Counter()
    
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    @objc
    func onTap(_ sender: Any) {
        counter.increment()
    }
    
    func bind() {
        // $ indentifier lets you access the generated publisher instance
        counter.$value.assign(to: \.text!, on: label).store(in: &cancellables)
    }
}

extension RefactoredViewController: ViewCode {
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

class Counter {
    // Property wrapper publisher
    @Published private(set) var value: String = "0"
    
    private var current = 0
    
    func increment() {
        current += 1
        value = "\(current)"
    }
}
