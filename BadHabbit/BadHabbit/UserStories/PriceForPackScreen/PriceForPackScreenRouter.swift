//
//  PriceForPackScreenRouter.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 6.09.23.
//

import Foundation

protocol PriceForPackScreenRouterProtocol {
    func presentEmptyScreen()
}

final class PriceForPackScreenRouter: PriceForPackScreenRouterProtocol {

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
