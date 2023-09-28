//
//  WelcomeNameScreenPresenter.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 15.09.23.
//

import Foundation

protocol WelcomeNameScreenPresenterProtocol {
    func startButtonTapped()
    var userFirstName: String { get }
}

final class WelcomeNameScreenPresenter: WelcomeNameScreenPresenterProtocol {

    private let router: WelcomeNameScreenRouterProtocol
    weak var view: WelcomeNameViewProtocol?
    var userFirstName = MockUser.firstName
    
    init(router: WelcomeNameScreenRouterProtocol) {
        self.router = router
    }

    func startButtonTapped() {
        router.presentСigarettesPerDayScreen()
    }
}
