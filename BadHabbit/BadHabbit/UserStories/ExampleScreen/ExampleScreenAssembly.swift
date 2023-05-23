//
//  ExampleScreenAssembly.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 23.05.23.
//

import UIKit

class ExampleScreenAssembly: ViewAssembly {
    
    private let viewModelAssembly: ViewModelAssembly
    
    init(viewModelAssembly: ViewModelAssembly) {
        self.viewModelAssembly = viewModelAssembly
    }
    
    func assembleView() -> UIViewController {
        let viewModel = viewModelAssembly.resolveExampleViewModel()
        let vc = ExampleScreenViewController(viewModel: viewModel)
        return vc
    }
}
