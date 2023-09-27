//
//  CigarettesInPackScreenAssembly.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 27/09/2023.
//

import UIKit

final class CigarettesInPackScreenAssembly: StoryAssembly {
    private let nextScreen: StoryAssembly
    private let globalCoordinator: IGlobalCoordinator
    
    init(nextScreen: StoryAssembly, globalCoordinator: IGlobalCoordinator) {
        self.nextScreen = nextScreen
        self.globalCoordinator = globalCoordinator
    }
    
    func assembleStory() -> UIViewController {
        let router = CigarettesInPackScreenRouter(
            emptyScreenAssembly: nextScreen,
            globalCoordinator: globalCoordinator
        )
        let presenter = CigarettesInPackScreenPresenter(router: router)
        let view = CigarettesInPackViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}
