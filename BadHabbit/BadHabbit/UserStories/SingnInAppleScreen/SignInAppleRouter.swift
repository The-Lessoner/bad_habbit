//
//  SignInAppleRouter.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.07.23.
//
import Foundation

protocol SignInAppleRouterProtocol {
    func presentBreakHabitScreen()
}

final class SignInAppleRouter: SignInAppleRouterProtocol {
    
    let nextScreen: StoryAssembly
    let globalCoordinator: IGlobalCoordinator
    
    init(nextScreen: StoryAssembly,
         globalCoordinator: IGlobalCoordinator) {
        self.nextScreen = nextScreen
        self.globalCoordinator = globalCoordinator
    }
    
    func presentBreakHabitScreen() {
        let vc = nextScreen.assembleStory()
        globalCoordinator.pushViewController(vc)
    }
}
