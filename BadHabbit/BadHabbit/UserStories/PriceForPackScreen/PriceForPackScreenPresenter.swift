//
//  PriceForPackScreenPresenter.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 6.09.23.
//

import Foundation

protocol PriceForPackScreenPresenterProtocol {
    func startButtonTapped()
    var currencies: [String] { get set }
    var currenciesCount: Int { get }
}

final class PriceForPackScreenPresenter: PriceForPackScreenPresenterProtocol {

    private let router: PriceForPackScreenRouterProtocol
    weak var view: PriceForPackViewProtocol?

    var currencies = ["$", "€", "Br", "₽", "₸", "₴"]
    var currenciesCount: Int { currencies.count }

    let hintText = Strings.PriceForPack.PriceValidatedTextField.HintLabelText.valid

    init(router: PriceForPackScreenRouterProtocol) {
        self.router = router
    }

    func startButtonTapped() {
        router.presentEmptyScreen()
    }
}
