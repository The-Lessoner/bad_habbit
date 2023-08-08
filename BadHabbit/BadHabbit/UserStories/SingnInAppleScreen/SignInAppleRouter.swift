//
//  SignInAppleRouter.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.07.23.
//
import Foundation

protocol SignInAppleRouterProtocol {
    func presentFillingPersonalDataScreen()
}

final class SignInAppleRouter: SignInAppleRouterProtocol {

    let nextScreen: FillingPersonalDataAssembly
    let globalCoordinator: IGlobalCoordinator

    init(nextScreen: FillingPersonalDataAssembly,
         globalCoordinator: IGlobalCoordinator) {
        self.nextScreen = nextScreen
        self.globalCoordinator = globalCoordinator
    }

    func presentFillingPersonalDataScreen() {
        let vc = nextScreen.assembleStory()
        vc.modalPresentationStyle = .fullScreen
        globalCoordinator.presentOnTopVisibleViewController(vc)
    }
}
