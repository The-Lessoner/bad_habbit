//
//  CigarettesInPackScreenPresenter.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 27/09/2023.
//

import Foundation

protocol CigarettesInPackScreenPresenterProtocol {
    func isValidCigarettesCount(userInput: String?) -> Bool
    func nextButtonTapped()
}

final class CigarettesInPackScreenPresenter: CigarettesInPackScreenPresenterProtocol {
    private let router: CigarettesInPackScreenRouterProtocol
    private var cigarettesCount: Int?
    
    weak var view: CigarettesInPackViewProtocol?
    
    init(router: CigarettesInPackScreenRouterProtocol) {
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
