//
//  WelcomeNameScreenAssembly.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 15.09.23.
//

import UIKit

final class WelcomeNameScreenAssembly: StoryAssembly {

    private let nextScreen: StoryAssembly
    private let globalCoordinator: IGlobalCoordinator

    init(nextScreen: StoryAssembly, globalCoordinator: IGlobalCoordinator) {
        self.nextScreen = nextScreen
        self.globalCoordinator = globalCoordinator
    }

    func assembleStory() -> UIViewController {
        let router = WelcomeNameScreenRouter(
            emptyScreenAssembly: nextScreen,
            globalCoordinator: globalCoordinator
        )
        let presenter = WelcomeNameScreenPresenter(router: router)
        let view = WelcomeNameViewController(presenter: presenter)
        presenter.view = view

        return view
    }
}
