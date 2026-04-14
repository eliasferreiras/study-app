//
//  ConcurrencyViewController.swift
//  StudyApp
//
//  Created by Elias Ferreira on 13/04/26.
//

import UIKit

class ConcurrencyViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel = ConcurrencyViewModel(service: FakeUserService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
        
        viewModel.fetchUsers()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        tableView.frame = view.bounds
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
    
    private func bindViewModel() {
        viewModel.onUsersUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.onError = { error in
            print("Error fetching users: \(error)")
        }
    }
}

extension ConcurrencyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let user = viewModel.users[indexPath.row]
        
        cell.textLabel?.text = user.name
        
        return cell
    }
}
