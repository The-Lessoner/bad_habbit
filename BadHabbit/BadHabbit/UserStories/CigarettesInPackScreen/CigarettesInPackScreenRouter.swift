//
//  CigarettesInPackScreenRouter.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 27/09/2023.
//

import Foundation

protocol CigarettesInPackScreenRouterProtocol {
    func presentEmptyScreen()
}

final class CigarettesInPackScreenRouter: CigarettesInPackScreenRouterProtocol {
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
