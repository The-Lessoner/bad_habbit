//
//  NewsViewModelAssembly.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 28/05/2023.
//

import Foundation

class NewsViewModelAssembly: ViewModelAssemblyProtocol {
    
    private let serviceAssembly: NewsServiceAssemblyProtocol
    
    init(serviceAssembly: NewsServiceAssemblyProtocol) {
        self.serviceAssembly = serviceAssembly
    }
    
    func resolveExampleViewModel() -> ExampleViewModelProtocol {
        NewsViewModel(newsService: serviceAssembly.resolveExampleService())
    }
}
