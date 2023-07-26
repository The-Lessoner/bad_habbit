//
//  FillingSignInDataPresenter.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.07.23.
//

import Foundation
import AuthenticationServices

protocol SignInDataPresenterProtocol {
    func authorizationButtonDidTap()
}

final class SignInDataPresenter: SignInDataPresenterProtocol {
    
    private let router: SignInDataRouterProtocol
    weak var view: SignInDataViewProtocol?
    
    init(router: SignInDataRouterProtocol) {
        self.router = router
    }

    func authorizationButtonDidTap() {
        router.presentAnotherScreen()
        
    }
}
