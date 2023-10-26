//
//  CigarettesPerDayScreenPresenter.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 17/09/2023.
//

import Foundation
import CoreData

protocol CigarettesPerDayScreenPresenterProtocol {
    func isValidCigarettesCount(_ cigarettesCount: Int) -> Bool
    func nextButtonTapped()
}

final class CigarettesPerDayScreenPresenter: CigarettesPerDayScreenPresenterProtocol {
    private let router: CigarettesPerDayScreenRouterProtocol
    private let persistentContainer: PersistentContainerProtocol
    private var cigarettesCount: Int?
    
    weak var view: CigarettesPerDayViewProtocol?
    
    init(router: CigarettesPerDayScreenRouterProtocol, persistentContainer: PersistentContainerProtocol) {
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
        router.presentCigarettesInPackScreen()
    }
    
    private func saveCigarettesCount() {
        guard let cigarettesCount = cigarettesCount,
              let smokingEntities = persistentContainer.fetch(
                request: Smoking.fetchRequest()
              ) as? [Smoking] else {
            return
        }

        if smokingEntities.isEmpty {
            let smoking = Smoking(context: persistentContainer.context)
            smoking.cigarettesPerDay = Int32(cigarettesCount)
        } else {
            smokingEntities[0].cigarettesPerDay = Int32(cigarettesCount)
        }
        
        persistentContainer.saveContext(backgroundContext: nil)
    }
}
