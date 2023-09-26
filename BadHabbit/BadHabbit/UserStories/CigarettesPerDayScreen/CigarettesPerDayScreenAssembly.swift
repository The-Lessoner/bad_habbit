//
//  CigarettesPerDayScreenAssembly.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 17/09/2023.
//

import UIKit

final class CigarettesPerDayScreenAssembly: StoryAssembly {
    private let nextScreen: StoryAssembly
    private let globalCoordinator: IGlobalCoordinator
    
    init(nextScreen: StoryAssembly, globalCoordinator: IGlobalCoordinator) {
        self.nextScreen = nextScreen
        self.globalCoordinator = globalCoordinator
    }
    
    func assembleStory() -> UIViewController {
        let router = CigarettesPerDayScreenRouter(
            emptyScreenAssembly: nextScreen,
            globalCoordinator: globalCoordinator)
        let presenter = CigarettesPerDayScreenPresenter(router: router)
        let view = CigarettesPerDayViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}
