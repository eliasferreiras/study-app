//
//  HomeViewController.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - UI.
    private(set) lazy var featuresTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: HomeConstants.cell)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Properties.
    let viewModel = HomeViewModel()

    // MARK: - Lifecycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.fetchFeatures()
    }
    
    // MARK: - Actions
    private func navigate(to feature: Feature) {
        viewModel.navigate(to: feature, from: self)
    }
}

// MARK: - TableView DataSource.
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.features.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeConstants.cell, for: indexPath)
        cell.textLabel?.text = viewModel.features[indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - TableView Delegate.
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigate(to: viewModel.features[indexPath.row])
    }
}

// MARK: - View Code.
extension HomeViewController: ViewCode {
    func setupViews() {
        title = HomeConstants.title
        featuresTableView.dataSource = self
        featuresTableView.delegate = self
    }
    
    func setupHierachy() {
        view.addSubview(featuresTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            featuresTableView.topAnchor.constraint(equalTo: view.topAnchor),
            featuresTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            featuresTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            featuresTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
