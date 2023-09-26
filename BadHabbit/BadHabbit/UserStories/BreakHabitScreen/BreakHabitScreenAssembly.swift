//
//  BreakHabitScreenAssembly.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 5.09.23.
//

import UIKit

final class BreakHabitScreenAssembly: StoryAssembly {

    private let nextScreen: StoryAssembly
    private let globalCoordinator: IGlobalCoordinator

    init(nextScreen: StoryAssembly, globalCoordinator: IGlobalCoordinator) {
        self.nextScreen = nextScreen
        self.globalCoordinator = globalCoordinator
    }

    func assembleStory() -> UIViewController {
        let router = BreakHabitScreenRouter(
            cigarettesPerDayScreenAssembly: nextScreen,
            globalCoordinator: globalCoordinator
        )
        let presenter = BreakHabitScreenPresenter(router: router)
        let view = BreakHabitViewController(presenter: presenter)
        presenter.view = view

        return view
    }

}
