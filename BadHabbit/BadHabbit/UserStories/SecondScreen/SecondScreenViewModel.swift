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
    var petitions: [Petition]? { get }
    var petitonsCount: Int? { get }
    
    func loadData()
    func bind()
    func getTitle(for index: Int) -> String?
}

final class SecondScreenViewModel: SecondScreenViewModelProtocol {
    
    var error: Observable<Error?>?
    var exampleText: Observable<[Petition]?>?
    
    private let exampleService: SecondScreenServiceProtocol
    var petitions: [Petition]? {
        didSet {
            bind()
        }
    }
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
            case .failure(let error):
                self.error?(error)
            }
        }
    }
    
    func bind() {
        DispatchQueue.main.async { [weak self] in
            self?.exampleText?(self?.petitions)
        }
    }
}
