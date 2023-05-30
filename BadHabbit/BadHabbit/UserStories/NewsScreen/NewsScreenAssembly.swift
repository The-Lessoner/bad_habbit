//
//  NewsScreenAssembly.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 25/05/2023.
//

import UIKit

class NewsScreenAssembly: ViewAssembly {
    
    private let viewModelAssembly: NewsViewModelAssembly
    
    init(viewModelAssembly: NewsViewModelAssembly) {
        self.viewModelAssembly = viewModelAssembly
    }
    
    func assembleView() -> UIViewController {
        let viewModel = viewModelAssembly.resolveExampleViewModel()
        let vc = NewsScreenViewController(viewModel: viewModel)
        return vc
    }
}
