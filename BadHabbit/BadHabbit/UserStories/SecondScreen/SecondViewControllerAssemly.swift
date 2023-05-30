//
//  SecondViewControllerAssemly.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.05.23.


import UIKit

class SecondViewControllerAssembly: ViewAssembly {
    
    private let viewModelAssembly: ViewModelAssembly
    
    init(viewModelAssembly: ViewModelAssembly) {
        self.viewModelAssembly = viewModelAssembly
    }
    
    func assembleView() -> UIViewController {
        let viewModel = viewModelAssembly.secondResolveExampleViewModel()
        let vc = SecondViewController(viewModel: viewModel)
        return vc
    }
}
