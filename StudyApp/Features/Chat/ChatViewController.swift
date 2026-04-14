//
//  ChatViewController.swift
//  StudyApp
//
//  Created by Elias Ferreira on 13/04/26.
//

import UIKit

class ChatViewController: UIViewController {
    
    // MARK: - UI
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private(set) lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Digite uma mensagem"
        return textField
    }()
    
    private(set) lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Enviar", for: .normal)
        button.addTarget(self, action: #selector(send), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    private(set) lazy var container: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Properties
    
    private let viewModel = ChatViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    // MARK: - Functions
    
    private func bind() {
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Actions
    
    @objc private func send() {
        guard let text = textField.text, !text.isEmpty else { return }
        viewModel.sendMessage(text)
        textField.text = ""
    }
}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let message = viewModel.messages[indexPath.row]
        
        cell.textLabel?.text = message.text
        
        return cell
    }
}

// MARK: - ViewCode
extension ChatViewController: ViewCode {
    func setupViews() {
        view.backgroundColor = .white
        tableView.dataSource = self
    }
    
    func setupHierachy() {
        stack.addArrangedSubview(textField)
        stack.addArrangedSubview(button)
        
        container.addArrangedSubview(tableView)
        container.addArrangedSubview(stack)
        
        view.addSubview(container)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}
