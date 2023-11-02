//
//  CigarettesPerDayScreenRouter.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 17/09/2023.
//

import Foundation

protocol CigarettesPerDayScreenRouterProtocol {
    func presentCigarettesInPackScreen()
}

final class CigarettesPerDayScreenRouter: CigarettesPerDayScreenRouterProtocol {
    private let cigarettesInPackScreenAssembly: StoryAssembly
    private let globalCoordinator: IGlobalCoordinator
    
    init(
        cigarettesInPackScreenAssembly: StoryAssembly,
        globalCoordinator: IGlobalCoordinator
    ) {
        self.cigarettesInPackScreenAssembly = cigarettesInPackScreenAssembly
        self.globalCoordinator = globalCoordinator
    }
    
    func presentCigarettesInPackScreen() {
        let vc = cigarettesInPackScreenAssembly.assembleStory()
        globalCoordinator.pushViewController(vc)
    }
}
