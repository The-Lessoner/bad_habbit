//
//  SignInAppleAssembly.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.07.23.
//

import UIKit

class SignInAppleAssembly: StoryAssembly {
    
    private let nextScreen: StoryAssembly
    private let globalCoordinator: IGlobalCoordinator
    
    init(nextScreen: StoryAssembly, globalCoordinator: IGlobalCoordinator) {
        self.nextScreen = nextScreen
        self.globalCoordinator = globalCoordinator
    }

    func assembleStory() -> UIViewController {
        let router = SignInAppleRouter(
            nextScreen: nextScreen,
            globalCoordinator: globalCoordinator
        )
        let presenter = SignInApplePresenter(router: router)
        let view = SignInAppleViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
}
