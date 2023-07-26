//
//  FillingSignInDataAssembly.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.07.23.
//

import UIKit

class SignInDataAssembly: ViewAssembly {

    private let globalCoordinator: IGlobalCoordinator

    init(globalCoordinator: IGlobalCoordinator) {
        self.globalCoordinator = globalCoordinator
    }

    func assembleView() -> UIViewController {
        let router = SignInDataRouter()
        let presenter = SignInDataPresenter(router: router)
        let view = SignInAppleViewController(presenter: presenter)
        presenter.view = view

        return view
    }

}
