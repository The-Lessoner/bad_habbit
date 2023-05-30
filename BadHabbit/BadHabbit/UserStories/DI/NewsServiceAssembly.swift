//
//  NewsServiceAssembly.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 28/05/2023.
//

import Foundation

protocol NewsServiceAssemblyProtocol {
    func resolveExampleService() -> NewsServiceProtocol
}

class NewsServiceAssembly: NewsServiceAssemblyProtocol {
    
    private let requestExecutor: NewsRequestExecutorProtocol
    
    init(requestExecutor: NewsRequestExecutorProtocol) {
        self.requestExecutor = requestExecutor
    }
    
    func resolveExampleService() -> NewsServiceProtocol {
        NewsService(requestExecutor: requestExecutor)
    }
}
