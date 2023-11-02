//
//  WelcomeNameScreenRouter.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 15.09.23.
//

import Foundation

protocol WelcomeNameScreenRouterProtocol {
    func presentСigarettesPerDayScreen()
}

final class WelcomeNameScreenRouter: WelcomeNameScreenRouterProtocol {
    
    private let сigarettesPerDayScreenAssembly: StoryAssembly
    private let globalCoordinator: IGlobalCoordinator
    
    init(
        сigarettesPerDayScreenAssembly: StoryAssembly,
        globalCoordinator: IGlobalCoordinator
    ) {
        self.сigarettesPerDayScreenAssembly = сigarettesPerDayScreenAssembly
        self.globalCoordinator = globalCoordinator
    }
    
    func presentСigarettesPerDayScreen() {
        let vc = сigarettesPerDayScreenAssembly.assembleStory()
        globalCoordinator.pushViewController(vc)
    }
}
