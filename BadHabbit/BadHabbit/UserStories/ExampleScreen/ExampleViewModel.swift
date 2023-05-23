//
//  ExampleViewModel.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

typealias Observable<T> = (T) -> Void

protocol ExampleViewModelProtocol: AnyObject {
    var error: Observable<Error?>? { get set }
    var exampleText: Observable<String?>? { get set }
    
    func loadData()
}

final class ExampleViewModel: ExampleViewModelProtocol {
    
    var error: Observable<Error?>?
    var exampleText: Observable<String?>?
    
    private let exampleService: ExampleServiceProtocol
    
    init(exampleService: ExampleServiceProtocol) {
        self.exampleService = exampleService
    }
    
    func loadData() {
        exampleService.loadExampleData { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let model):
                self.error?(nil)
                self.exampleText?(model.text)
            case .failure(let error):
                self.error?(error)
                self.exampleText?(nil)
            }
        }
    }
}
