//
//  SignUpScreenAssembly.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 27/07/2023.
//

import UIKit

final class SignUpScreenAssembly: StoryAssembly {
    private let nextScreen: StoryAssembly
    private let globalCoordinator: IGlobalCoordinator
    
    init(nextScreen: StoryAssembly, globalCoordinator: IGlobalCoordinator) {
        self.nextScreen = nextScreen
        self.globalCoordinator = globalCoordinator
    }
    
    func assembleStory() -> UIViewController {
        let router = SignUpScreenRouter(
            nextScreen: nextScreen,
            globalCoordinator: globalCoordinator
        )
        let presenter = SignUpScreenPresenter(router: router)
        let view = SignUpViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}
