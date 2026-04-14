//
//  ViewModelState.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import Foundation

public enum ViewModelState<T> {
    case loading(_ isLoading: Bool)
    case data(T)
    case failure(Error)
}
