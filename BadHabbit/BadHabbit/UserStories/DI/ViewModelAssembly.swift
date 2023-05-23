//
//  ViewModelAssembly.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import Foundation

protocol ViewModelAssemblyProtocol {
    func resolveExampleViewModel() -> ExampleViewModelProtocol
}

class ViewModelAssembly: ViewModelAssemblyProtocol {
    
    private let serviceAssembly: ServiceAssemblyProtocol
    
    init(serviceAssembly: ServiceAssemblyProtocol) {
        self.serviceAssembly = serviceAssembly
    }
    
    func resolveExampleViewModel() -> ExampleViewModelProtocol {
        ExampleViewModel(exampleService: serviceAssembly.resolveExampleService())
    }
}
