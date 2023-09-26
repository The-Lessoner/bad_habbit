//
//  CigarettesPerDayScreenRouter.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 17/09/2023.
//

import Foundation

protocol CigarettesPerDayScreenRouterProtocol {
    func presentEmptyScreen()
}

final class CigarettesPerDayScreenRouter: CigarettesPerDayScreenRouterProtocol {
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
