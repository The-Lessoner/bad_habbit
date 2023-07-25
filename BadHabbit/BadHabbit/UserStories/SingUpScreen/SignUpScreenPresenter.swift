//
//  SignUpScreenPresenter.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 24/07/2023.
//

import Foundation

protocol SignUpScreenPresenterProtocol {
    func startButtonTapped()
}

final class SignUpScreenPresenter: SignUpScreenPresenterProtocol {
    
    weak var view: SignUpViewProtocol?
    private let router: SignUpRouterProtocol
    
    init(router: SignUpRouterProtocol) {
        self.router = router
    }
    
    func startButtonTapped() {
        router.presentAnotherScreen()
    }
}
