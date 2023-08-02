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

    let nextScreen: FillingPersonalDataAssembly
    let globalCoordinator: IGlobalCoordinator

    init(nextScreen: FillingPersonalDataAssembly,
         globalCoordinator: IGlobalCoordinator) {
        self.nextScreen = nextScreen
        self.globalCoordinator = globalCoordinator
    }

    func presentAnotherScreen() {
        let vc = nextScreen.assembleStory()
        globalCoordinator.presentOnTopVisibleViewController(vc)
    }
}
