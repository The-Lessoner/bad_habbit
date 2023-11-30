//
//  BreakHabitScreenRouter.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 5.09.23.
//

import Foundation

protocol BreakHabitScreenRouterProtocol {
    func presentWelcomeNameScreen()
}

final class BreakHabitScreenRouter: BreakHabitScreenRouterProtocol {
    
    private let welcomeNameScreenAssembly: StoryAssembly
    private let globalCoordinator: IGlobalCoordinator
    
    init(
        welcomeNameScreenAssembly: StoryAssembly,
        globalCoordinator: IGlobalCoordinator
    ) {
        self.welcomeNameScreenAssembly = welcomeNameScreenAssembly
        self.globalCoordinator = globalCoordinator
    }
    
    func presentWelcomeNameScreen() {
        let vc = welcomeNameScreenAssembly.assembleStory()
        globalCoordinator.pushViewController(vc)
    }
}
