//
//  SecondScreenService.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.05.23.
//

import Foundation

protocol SecondScreenServiceProtocol {
    func loadExampleData(completion: @escaping (Result<SecondScreenModel, Error>) -> Void)
}

final class SecondScreenService: SecondScreenServiceProtocol {
    
    private let requestExecutor: RequestExecutorProtocol
    
    init(requestExecutor: RequestExecutorProtocol) {
        self.requestExecutor = requestExecutor
    }
    
    func loadExampleData(completion: @escaping(Result<SecondScreenModel, Error>) -> Void) {
        let request = Request(
            path: Constants.APIDetails.APIPath,
            params: [:]
        )
        
        let parser = SecondScreenModelParser()
        
        requestExecutor.perform(
            request: request,
            parser: parser,
            completion: completion
        )
    }
}
