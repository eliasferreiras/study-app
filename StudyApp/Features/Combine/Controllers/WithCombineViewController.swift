//
//  WithCombineViewController.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import UIKit
import Combine

class WithCombineViewController: UIViewController {
    
    // MARK: - UI
    
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
    
    // MARK: - Properties
    
    var current = 0;
    
    // Publisher declares a type that delivers a sequence of values over time
    let publisher = PassthroughSubject<Int, Never>() // CurrentValueSubject
    
    var cancellables = Set<AnyCancellable>()
    
    func bind() {
        // map operator
        let resultPublisher = publisher.map { (input) -> String in
            return "\(input)"
        }
        
        // assign subscriver/operator
        resultPublisher
            .assign(to: \.text!, on: label)
            .store(in: &cancellables)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    @objc
    func onTap(_ sender: Any) {
        current += 1
        publisher.send(current)
    }
}

extension WithCombineViewController: ViewCode {
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
