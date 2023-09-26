//
//  BreakHabitScreenRouter.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 5.09.23.
//

import Foundation

protocol BreakHabitScreenRouterProtocol {
    func presentCigarettesPerDayScreen()
}

final class BreakHabitScreenRouter: BreakHabitScreenRouterProtocol {
    
    private let cigarettesPerDayScreenAssembly: StoryAssembly
    private let globalCoordinator: IGlobalCoordinator
    
    init(
        cigarettesPerDayScreenAssembly: StoryAssembly,
        globalCoordinator: IGlobalCoordinator
    ) {
        self.cigarettesPerDayScreenAssembly = cigarettesPerDayScreenAssembly
        self.globalCoordinator = globalCoordinator
    }
    
    func presentCigarettesPerDayScreen() {
        let vc = cigarettesPerDayScreenAssembly.assembleStory()
        globalCoordinator.pushViewController(vc)
    }
}
