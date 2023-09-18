//
//  WelcomeNameScreenRouter.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 15.09.23.
//

import Foundation

protocol WelcomeNameScreenRouterProtocol {
    func presentEmptyScreen()
}

final class WelcomeNameScreenRouter: WelcomeNameScreenRouterProtocol {
    
    private let emptyScreenAssembly: StoryAssembly
    private let globalCoordinator: IGlobalCoordinator
    
    init(
        emptyScreenAssembly: StoryAssembly,
        globalCoordinator: IGlobalCoordinator
    ) {
        self.emptyScreenAssembly = emptyScreenAssembly
        self.globalCoordinator = globalCoordinator
    }
    
    func presentEmptyScreen() {
        let vc = emptyScreenAssembly.assembleStory()
        globalCoordinator.pushViewController(vc)
    }
}
