//
//  ServiceAssembly.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import Foundation

protocol ServiceAssemblyProtocol {
    func resolveExampleService() -> ExampleServiceProtocol
}

class ServiceAssembly: ServiceAssemblyProtocol {
    
    private let requestExecutor: RequestExecutorProtocol
    
    init(requestExecutor: RequestExecutorProtocol) {
        self.requestExecutor = requestExecutor
    }
    
    func resolveExampleService() -> ExampleServiceProtocol {
        ExampleService(requestExecutor: requestExecutor)
    }
}
