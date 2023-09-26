//
//  BreakHabitScreenPresenter.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 5.09.23.
//

import Foundation

protocol BreakHabitScreenPresenterProtocol {
    func startButtonTapped()
}

final class BreakHabitScreenPresenter: BreakHabitScreenPresenterProtocol {
    
    private let router: BreakHabitScreenRouterProtocol
    weak var view: BreakHabitViewProtocol?
    
    init(router: BreakHabitScreenRouterProtocol) {
        self.router = router
    }
    
    func startButtonTapped() {
        router.presentCigarettesPerDayScreen()
    }
}
