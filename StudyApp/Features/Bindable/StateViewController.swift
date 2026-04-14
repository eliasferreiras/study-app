//
//  StateViewController.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import UIKit

class StateViewController: UIViewController {
    
    private(set) lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Load", for: .normal)
        button.addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let viewModel = StateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setup()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.state.bind { [weak self] state in
            guard let state else { return }
            
            switch state {
            case .loading(let isLoading):
                if isLoading {
                    self?.loadingLabel.text = "Loading..."
                    self?.contentLabel.text = "..."
                } else {
                    self?.removeLoading()
                }
            case .data:
                self?.setupData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc
    func onTap(_ sender: Any) {
        viewModel.fetchData()
    }
    
    private func removeLoading() {
        loadingLabel.text = "Loaded!"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loadingLabel.text = ""
        }
    }
    
    private func setupData() {
        contentLabel.text = viewModel.model?.text
    }
}

extension StateViewController: ViewCode {
    func setupViews() {
        view.backgroundColor = .systemBackground
    }
    
    func setupHierachy() {
        view.addSubview(loadingLabel)
        view.addSubview(contentLabel)
        view.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Loading Label
            loadingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // Content Label
            contentLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            contentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // Button
            button.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
