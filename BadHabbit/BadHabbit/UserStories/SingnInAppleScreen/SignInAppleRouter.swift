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
    
    private let breakHabitScreenAssembly: StoryAssembly
    private let globalCoordinator: IGlobalCoordinator
    
    init(breakHabitScreenAssembly: StoryAssembly,
         globalCoordinator: IGlobalCoordinator) {
        self.breakHabitScreenAssembly = breakHabitScreenAssembly
        self.globalCoordinator = globalCoordinator
    }
    
    func presentBreakHabitScreen() {
        let vc = breakHabitScreenAssembly.assembleStory()
        globalCoordinator.pushViewController(vc)
    }
}
