//
//  CigarettesPerDayScreenPresenter.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 17/09/2023.
//

import Foundation

protocol CigarettesPerDayScreenPresenterProtocol {
    func isValidCigarettesCount(userInput: String?) -> Bool
    func nextButtonTapped()
}

final class CigarettesPerDayScreenPresenter: CigarettesPerDayScreenPresenterProtocol {
    private let router: CigarettesPerDayScreenRouterProtocol
    private var cigarettesCount: Int?
    
    weak var view: CigarettesPerDayViewProtocol?
    
    init(router: CigarettesPerDayScreenRouterProtocol) {
        self.router = router
    }
    
    func isValidCigarettesCount(userInput: String?) -> Bool {
        if let userInput = userInput,
              !userInput.isEmpty,
           let cigarettesCount = Int(userInput),
           (1...9999).contains(cigarettesCount) {
            self.cigarettesCount = cigarettesCount
            return true
        } else {
            return false
        }
    }
    
    func nextButtonTapped() {
        router.presentEmptyScreen()
    }
}
