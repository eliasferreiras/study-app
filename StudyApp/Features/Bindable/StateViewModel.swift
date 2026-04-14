//
//  StateViewModel.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import Foundation

class StateViewModel {
    let service = StateService()
    // State Object
    var state: Bindable<ViewModelState<StateModel?>?> = Bindable(nil)
    
    private(set) var model: StateModel? {
        didSet { state.value = .data(model) }
    }
    
    func fetchData() {
        state.value = .loading(true)
        service.getContent { [weak self] result in
            switch result {
            case .success(let model):
                self?.state.value = .loading(false)
                self?.model = StateModel(text: model)
            case .failure(let error):
                self?.state.value = .failure(error)
            }
        }
    }
}
