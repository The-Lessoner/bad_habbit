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
    
    let nextScreen: SignInDataAssembly
    let globalCoordinator: IGlobalCoordinator
    
    init(
        nextScreen: SignInDataAssembly,
        globalCoordinator: IGlobalCoordinator
    ) {
        self.nextScreen = nextScreen
        self.globalCoordinator = globalCoordinator
     }

    func presentSignInAppleScreen() {
        let vc = nextScreen.assembleStory()
        globalCoordinator.presentOnTopVisibleViewController(vc)
    }
}
