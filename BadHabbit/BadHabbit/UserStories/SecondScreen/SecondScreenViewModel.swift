//
//  SecondScreenViewModel.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 25.05.23.
//

protocol SecondScreenViewModelProtocol: AnyObject {
    var error: Observable<Error?>? { get set }
    var exampleText: Observable<[Petition]?>? { get set }
    var petitions: [Petition]? { get }

    func loadData()
}

final class SecondScreenViewModel: SecondScreenViewModelProtocol {
    
    var error: Observable<Error?>?
    var exampleText: Observable<[Petition]?>?
    
    private let exampleService: SecondScreenServiceProtocol
    var petitions: [Petition]?
    
    init(exampleService: SecondScreenService) {
        self.exampleService = exampleService
    }
    
    func loadData() {
        exampleService.loadExampleData() { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let model):
                self.error?(nil)
                petitions = model.results
                self.exampleText?(petitions)
            case .failure(let error):
                self.error?(error)
                self.exampleText?(nil)
            }
        }
    }
}
