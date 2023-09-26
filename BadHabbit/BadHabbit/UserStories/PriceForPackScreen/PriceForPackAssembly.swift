//
//  PriceForPackScreenAssembly.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 6.09.23.
//

import UIKit

final class PriceForPackScreenAssembly: StoryAssembly {

    private let nextScreen: StoryAssembly
    private let globalCoordinator: IGlobalCoordinator

    init(nextScreen: StoryAssembly, globalCoordinator: IGlobalCoordinator) {
        self.nextScreen = nextScreen
        self.globalCoordinator = globalCoordinator
    }

    func assembleStory() -> UIViewController {
        let router = PriceForPackScreenRouter(
            emptyScreenAssembly: nextScreen,
            globalCoordinator: globalCoordinator
        )
        let presenter = PriceForPackScreenPresenter(router: router)
        let view = PriceForPackViewController(presenter: presenter)
        presenter.view = view

        return view
    }
}
