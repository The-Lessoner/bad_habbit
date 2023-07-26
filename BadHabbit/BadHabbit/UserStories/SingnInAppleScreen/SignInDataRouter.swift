//
//  FillingSignInDataRouter.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.07.23.
//
import Foundation

protocol SignInDataRouterProtocol {
    func presentAnotherScreen()
}

final class SignInDataRouter: SignInDataRouterProtocol {

    let nextScreen: ViewAssembly
    let globalCoordinator: IGlobalCoordinator

    init(nextScreen: ViewAssembly,
         globalCoordinator: IGlobalCoordinator) {
        self.nextScreen = nextScreen
        self.globalCoordinator = globalCoordinator
    }

    func presentAnotherScreen() {
        let vc = nextScreen.assembleView()
        globalCoordinator.presentOnTopVisibleViewController(vc, animated: true, completion: nil)
    }
}
