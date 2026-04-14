//
//  ChatViewController.swift
//  StudyApp
//
//  Created by Elias Ferreira on 13/04/26.
//

import Combine
import UIKit

class ChatViewController: UIViewController {
    
    // MARK: - UI
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
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
    
    typealias Datasource = UITableViewDiffableDataSource<ChatSection, ChatMessage>
    
    private var datasource: Datasource? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    private let viewModel = ChatViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupDataSource()
        bind()
    }
    
    // MARK: - Functions
    
    private func bind() {
        viewModel.$messages
            .sink() { [weak self] messages in
                self?.applySnapshot(messages: messages)
            }
            .store(in: &cancellables)
    }
    
    func setupDataSource() {
        datasource = Datasource(tableView: tableView) { tableView, indexPath, message in
            if indexPath.row.isMultiple(of: 2) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SelfChatCell.identifier, for: indexPath) as? SelfChatCell else {
                    return UITableViewCell()
                }
                
                cell.configure(with: message)
                
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SenderChatCell.identifier, for: indexPath) as? SenderChatCell else {
                    return UITableViewCell()
                }
                
                cell.configure(with: message)
                
                return cell
            }
        }
    }
    
    func applySnapshot(messages: [ChatMessage]) {
        var snapshot = NSDiffableDataSourceSnapshot<ChatSection, ChatMessage>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(messages, toSection: .main)
        
        datasource?.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - Actions
    
    @objc private func send() {
        guard let text = textField.text, !text.isEmpty else { return }
        viewModel.sendMessage(text)
        textField.text = ""
    }
}

// MARK: - ViewCode
extension ChatViewController: ViewCode {
    func setupViews() {
        view.backgroundColor = .white
        tableView.register(SelfChatCell.self, forCellReuseIdentifier: SelfChatCell.identifier)
        tableView.register(SenderChatCell.self, forCellReuseIdentifier: SenderChatCell.identifier)
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
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
}
