//
//  SelfChatCell.swift
//  StudyApp
//
//  Created by Elias Ferreira on 13/04/26.
//

import UIKit

class SelfChatCell: UITableViewCell {
    
    // MARK: - UI

    private(set) lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.backgroundColor = .clear
        
        return label
    }()
    
    private(set) lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMinYCorner
        ]
        view.layer.masksToBounds = true
        
        return view
    }()
    
    // MARK: - Properties
    
    static let identifier: String = "SelfChatCell"
    
    // MARK: - Constructors
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    // MARK: - Functions
    
    func configure(with message: ChatMessage) {
        messageLabel.text = message.text
    }
}

// MARK: - View Code Protocol
extension SelfChatCell: ViewCode {
    func setupViews() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupHierachy() {
        contentView.addSubview(containerView)
        containerView.addSubview(messageLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containerView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
}

