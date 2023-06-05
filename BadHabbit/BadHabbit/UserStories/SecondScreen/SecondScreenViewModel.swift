//
//  SecondScreenViewModel.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 25.05.23.
//
import Foundation
protocol SecondScreenViewModelProtocol: AnyObject {
    var error: Observable<Error?>? { get set }
    var exampleText: Observable<[Petition]?>? { get set }
    var petitonsCount: Int? { get }
    
    func loadData()
    func getTitle(for index: Int) -> String?
}

final class SecondScreenViewModel: SecondScreenViewModelProtocol {
    
    var error: Observable<Error?>?
    var exampleText: Observable<[Petition]?>?
    
    private let exampleService: SecondScreenServiceProtocol
    var petitions: [Petition]?
    var petitonsCount: Int? {
        petitions?.count
    }
    
    init(exampleService: SecondScreenServiceProtocol) {
        self.exampleService = exampleService
    }
    
    func getTitle(for index: Int) -> String? {
        petitions?[index].title
    }
    
    func loadData() {
        exampleService.loadExampleData() { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let model):
                self.error?(nil)
                petitions = model.results
                DispatchQueue.main.async {
                    self.exampleText?(self.petitions)
                }
            case .failure(let error):
                self.exampleText?(nil)
                DispatchQueue.main.async {
                    self.error?(error)
                }
            }
        }
    }
}
