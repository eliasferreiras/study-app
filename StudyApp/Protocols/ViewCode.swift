//
//  ViewCode.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import Foundation

public protocol ViewCode {
    func setup()
    func setupViews()
    func setupHierachy()
    func setupConstraints()
}

extension ViewCode {
    public func setup() {
        setupViews()
        setupHierachy()
        setupConstraints()
    }
}
