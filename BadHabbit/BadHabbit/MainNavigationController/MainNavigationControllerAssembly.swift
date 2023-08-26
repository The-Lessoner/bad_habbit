//
//  MainNavigationControllerAssembly.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 26.08.23.
//

import UIKit

final class MainNavigationControllerAssembly {

    private let signUpScreenAssembly: StoryAssembly

    init(
        signUpScreenAssembly: StoryAssembly
    ) {
        self.signUpScreenAssembly = signUpScreenAssembly
    }

    func assemble() -> UIViewController {

        let signUpVC = signUpScreenAssembly.assembleStory()
        let mainNavigationController = UINavigationController(rootViewController: signUpVC)

        return mainNavigationController
    }
}
