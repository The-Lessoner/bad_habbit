//
//  CigarettesInPackScreenPresenter.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 27/09/2023.
//

import Foundation

protocol CigarettesInPackScreenPresenterProtocol {
    func isValidCigarettesCount(_ cigarettesCount: Int) -> Bool
    func nextButtonTapped()
}

final class CigarettesInPackScreenPresenter: CigarettesInPackScreenPresenterProtocol {
    private let router: CigarettesInPackScreenRouterProtocol
    private let persistentContainer: PersistentContainerProtocol
    private var cigarettesCount: Int?
    
    weak var view: CigarettesInPackViewProtocol?
    
    init(router: CigarettesInPackScreenRouterProtocol, persistentContainer: PersistentContainerProtocol) {
        self.router = router
        self.persistentContainer = persistentContainer
    }
    
    func isValidCigarettesCount(_ cigarettesCount: Int) -> Bool {
        if (1...9999).contains(cigarettesCount) {
            self.cigarettesCount = cigarettesCount
            return true
        } else {
            return false
        }
    }
    
    func nextButtonTapped() {
        saveCigarettesCount()
        router.presentEmptyScreen()
    }
    
    private func saveCigarettesCount() {
        guard let cigarettesCount = cigarettesCount,
              let smokingEntities = persistentContainer.fetch(
                request: Smoking.fetchRequest()
              ) as? [Smoking],
              !smokingEntities.isEmpty else {
            return
        }

        smokingEntities[0].cigarettesInPack = Int32(cigarettesCount)
        
        persistentContainer.saveContext(backgroundContext: nil)
    }
}
