//
//  NewsScreenAssembly.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 25/05/2023.
//

import UIKit

class NewsScreenAssembly: ViewAssembly {
    
    private let viewModelAssembly: ViewModelAssembly
    
    init(viewModelAssembly: ViewModelAssembly) {
        self.viewModelAssembly = viewModelAssembly
    }
    
    func assembleView() -> UIViewController {
        let viewModel = viewModelAssembly.resolveNewsViewModel()
        let vc = NewsScreenViewController(viewModel: viewModel)
        return vc
    }
}
