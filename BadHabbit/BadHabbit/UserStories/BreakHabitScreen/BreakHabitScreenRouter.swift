//
//  BreakHabitScreenRouter.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 5.09.23.
//

import Foundation

protocol BreakHabitScreenRouterProtocol {
    func presentPriceForPackScreen()
}

final class BreakHabitScreenRouter: BreakHabitScreenRouterProtocol {
    
    private let priceForPackScreenAssembly: StoryAssembly
    private let globalCoordinator: IGlobalCoordinator
    
    init(
        priceForPackScreenAssembly: StoryAssembly,
        globalCoordinator: IGlobalCoordinator
    ) {
        self.priceForPackScreenAssembly = priceForPackScreenAssembly
        self.globalCoordinator = globalCoordinator
    }
    
    func presentPriceForPackScreen() {
        let vc = priceForPackScreenAssembly.assembleStory()
        globalCoordinator.pushViewController(vc)
    }
}
