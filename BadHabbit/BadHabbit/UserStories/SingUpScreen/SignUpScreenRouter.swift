//
//  SignUpScreenRouter.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 24/07/2023.
//

import Foundation

protocol SignUpRouterProtocol {
    func presentSignInAppleScreen()
}

final class SignUpScreenRouter: SignUpRouterProtocol {
    
    private let signInAppleScreenAssembly: StoryAssembly
    private let globalCoordinator: IGlobalCoordinator
    
    init(
        signInAppleScreenAssembly: StoryAssembly,
        globalCoordinator: IGlobalCoordinator
    ) {
        self.signInAppleScreenAssembly = signInAppleScreenAssembly
        self.globalCoordinator = globalCoordinator
    }

    func presentSignInAppleScreen() {
        let vc = signInAppleScreenAssembly.assembleStory()
        globalCoordinator.presentOnTopVisibleViewController(vc)
    }
}
