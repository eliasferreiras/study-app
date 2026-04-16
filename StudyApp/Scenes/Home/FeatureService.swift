//
//  FeatureService.swift
//  StudyApp
//
//  Created by Elias Ferreira on 07/04/26.
//

import Foundation

class FeatureService {
    static func fetchAll(completion: @escaping ([Feature]) -> Void) {
        completion(Feature.mock)
    }
}
