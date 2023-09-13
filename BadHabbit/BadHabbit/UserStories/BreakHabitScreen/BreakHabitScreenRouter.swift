//
//  BreakHabitScreenRouter.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 5.09.23.
//

import Foundation

protocol BreakHabitScreenRouterProtocol {
    func presentEmptyScreen()
}

final class BreakHabitScreenRouter: BreakHabitScreenRouterProtocol {
    
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
