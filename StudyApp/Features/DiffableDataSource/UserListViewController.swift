//
//  UserListViewController.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import UIKit
import Combine

nonisolated enum Section {
    case main
}

class UserListViewController: UIViewController {
    typealias Datasource = UITableViewDiffableDataSource<Section, User>
    
    private let addButton = UIButton(type: .system)
    private let editButton = UIButton(type: .system)
    private let tableView = UITableView()
    private let viewModel = UserListViewModel(service: FakeUserService())
    private var cancellables = Set<AnyCancellable>()
    
    private var datasource: Datasource? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupDataSource()
        bind()
        viewModel.fetchUsers()
    }
    
    @objc
    private func addUser() {
        viewModel.addUser(User(id: UUID(), name: "New User"))
    }
    
    @objc
    private func edit() {
        viewModel.toggleEdit()
    }
    
    func delete(user: User) {
        viewModel.deleteUser(user: user)
    }
    
    func bind() {
        viewModel.$users
            .sink {
                [weak self] users in
                self?.applySnapshot(users: users)
            }
            .store(in: &cancellables)
        
        viewModel.$isEditing
            .sink {
                [weak self] isEditing in
                self?.tableView.isEditing = isEditing
                let title = isEditing ? "Cancelar" : "Editar"
                self?.editButton.setTitle(title, for: .normal)
            }
            .store(in: &cancellables)
    }
    
    func setupDataSource() {
        datasource = Datasource(tableView: tableView) {
            _, _, user in
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            
            cell.textLabel?.text = user.name
            return cell
        }
    }
    
    func applySnapshot(users: [User]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(users, toSection: .main)
        
        datasource?.apply(snapshot, animatingDifferences: true)
    }
}

extension UserListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        
        guard let user = datasource?.itemIdentifier(for: indexPath) else {
            return nil
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self] _, _, completion in
            
            self?.delete(user: user)
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension UserListViewController: ViewCode {
    func setupViews() {
        view.backgroundColor = .white
        addButton.setTitle("Teste Adicionar", for: .normal)
        addButton.addTarget(self, action: #selector(addUser), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        editButton.addTarget(self, action: #selector(edit), for: .touchUpInside)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
    }
    
    func setupHierachy() {
        view.addSubview(addButton)
        view.addSubview(editButton)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            editButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
