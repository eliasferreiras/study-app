//
//  UserViewController.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import UIKit
import Combine

class UserViewController: UIViewController {
    
    private let viewModel = UserViewModel(service: FakeUserService())
    private var cancellables = Set<AnyCancellable>()
    
    private let label = UILabel()
    private let button = UIButton(type: .system)
    private let loadingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Fetch User", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        loadingLabel.text = "Loading..."
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(loadingLabel)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        button.addTarget(self, action: #selector(fetchUsers), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.$users
            .map{ users in
                users.map { $0.name }.joined(separator: "\n")
            }
            .sink { [weak self] text in
                self?.label.text = text
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .sink { [weak self] isLoading in
                self?.loadingLabel.isHidden = !isLoading
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .sink { error in
                if let error = error {
                    print("Error:", error)
                }
            }
            .store(in: &cancellables)
    }
    
    @objc private func fetchUsers() {
        viewModel.fetchUsers()
    }
}
