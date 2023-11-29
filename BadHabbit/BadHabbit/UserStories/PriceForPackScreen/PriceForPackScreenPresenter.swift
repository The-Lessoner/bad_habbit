//
//  PriceForPackScreenPresenter.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 6.09.23.
//

import Foundation
import CoreData

protocol PriceForPackScreenPresenterProtocol {
    func startButtonTapped(price: Double, currency: String)
    var currencies: [String] { get set }
    var currenciesCount: Int { get }
}

final class PriceForPackScreenPresenter: PriceForPackScreenPresenterProtocol {
    
    private let router: PriceForPackScreenRouterProtocol
    weak var view: PriceForPackViewProtocol?
    
    var currencies = ["$", "€", "Br", "₽", "₸", "₴"]
    var currenciesCount: Int { currencies.count }
    private let persistentContainer: PersistentContainerProtocol
    private var priceForPack: Double?
    var currency: String?
    
    let hintText = Strings.PriceForPack.PriceValidatedTextField.hintLabelText
    
    init(router: PriceForPackScreenRouterProtocol, persistentContainer: PersistentContainerProtocol) {
        self.router = router
        self.persistentContainer = persistentContainer
    }
    
    func startButtonTapped(price: Double, currency: String) {
        saveToCoreData(price: price, currency: currency)
        router.presentEmptyScreen()
    }
    
    func saveToCoreData(price: Double, currency: String) {
        guard let smokingEntities = persistentContainer.fetch(
            request: Smoking.fetchRequest()
        ) as? [Smoking] else {
            return
        }
        
        if smokingEntities.isEmpty {
            let smoking = Smoking(context: persistentContainer.context)
            smoking.priceForPack = price
            smoking.currency = currency
        } else {
            smokingEntities[0].priceForPack = price
            smokingEntities[0].currency = currency
        }
        
        persistentContainer.saveContext(backgroundContext: nil)
    }
}
