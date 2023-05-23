//
//  ExampleService.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import Foundation

protocol ExampleServiceProtocol {
    func loadExampleData(completion: (Result<ExampleModel, Error>) -> Void)
}

final class ExampleService: ExampleServiceProtocol {
    
    private let requestExecutor: RequestExecutorProtocol
    
    init(requestExecutor: RequestExecutorProtocol) {
        self.requestExecutor = requestExecutor
    }
    
    func loadExampleData(completion: (Result<ExampleModel, Error>) -> Void) {
        let request = Request(
            path: "/exampleData",
            params: ["random": true]
        )
        let parser = ExampleModelParser()
        
        requestExecutor.perform(
            request: request,
            parser: parser,
            completion: completion
        )
    }
}
