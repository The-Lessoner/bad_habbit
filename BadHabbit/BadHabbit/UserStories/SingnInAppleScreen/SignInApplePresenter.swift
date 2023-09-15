//
//  SignInApplePresenter.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.07.23.
//

import Foundation

protocol SignInApplePresenterProtocol {
    func authorizationButtonDidTap()
}

final class SignInApplePresenter: SignInApplePresenterProtocol {
    
    private let router: SignInAppleRouterProtocol
    weak var view: SignInAppleViewProtocol?
    
    init(router: SignInAppleRouterProtocol) {
        self.router = router
    }

    func authorizationButtonDidTap() {
        router.presentBreakHabitScreen()
    }
}
