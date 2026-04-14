//
//  ChatViewController.swift
//  StudyApp
//
//  Created by Elias Ferreira on 13/04/26.
//

import UIKit

class ChatViewController: UIViewController {
    
    private let tableView = UITableView()
    private let textField = UITextField()
    private let button = UIButton(type: .system)
    
    private let viewModel = ChatViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bind()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "Digite uma mensagem"
        
        button.setTitle("Enviar", for: .normal)
        button.addTarget(self, action: #selector(send), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [textField, button])
        stack.axis = .horizontal
        stack.spacing = 8
        
        let container = UIStackView(arrangedSubviews: [tableView, stack])
        container.axis = .vertical
        container.spacing = 8
        container.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func bind() {
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    @objc private func send() {
        guard let text = textField.text, !text.isEmpty else { return }
        viewModel.sendMessage(text)
        textField.text = ""
    }
}

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
