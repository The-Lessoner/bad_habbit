//
//  SecondScreenViewModel.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 25.05.23.
//

import Foundation
//typealias Observable<T> = (T) -> Void

protocol SecondScreenViewModelProtocol: AnyObject {
    var error: Observable<Error?>? { get set }
    var exampleText: Observable<[Petition]?>? { get set }

    func loadData()
}

final class SecondScreenViewModel: SecondScreenViewModelProtocol {
    
    var error: Observable<Error?>?
    var exampleText: Observable<[Petition]?>?
    
    private let exampleService: SecondScreenServiceProtocol
    
    init(exampleService: SecondScreenService) {
        self.exampleService = exampleService
    }
    
    func loadData() {
        exampleService.loadExampleData() { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let model):
                self.error?(nil)
                self.exampleText?(model.results)
            case .failure(let error):
                self.error?(error)
                self.exampleText?(nil)
            }
        }
    }
}
