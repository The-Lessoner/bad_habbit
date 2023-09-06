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
    
    let nextScreen: StoryAssembly
    let globalCoordinator: IGlobalCoordinator
    
    init(
        nextScreen: StoryAssembly,
        globalCoordinator: IGlobalCoordinator
    ) {
        self.nextScreen = nextScreen
        self.globalCoordinator = globalCoordinator
    }
    
    func presentEmptyScreen() {
        let vc = nextScreen.assembleStory()
        globalCoordinator.pushViewController(vc)
    }
}
