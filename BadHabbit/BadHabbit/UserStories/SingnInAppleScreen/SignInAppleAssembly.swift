//
//  SignInAppleAssembly.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.07.23.
//

import UIKit

class SignInAppleAssembly: StoryAssembly {
    
    private let alertAssembly: AlertAssemblyProtocol
    private let globalCoordinator: IGlobalCoordinator
    
    init(alertAssembly: AlertAssemblyProtocol, globalCoordinator: IGlobalCoordinator) {
        self.alertAssembly = alertAssembly
        self.globalCoordinator = globalCoordinator
    }

    func assembleStory() -> UIViewController {
        let router = SignInAppleRouter(nextScreen: FillingPersonalDataAssembly(alertAssembly: alertAssembly), globalCoordinator: globalCoordinator)
        let presenter = SignInApplePresenter(router: router)
        let view = SignInAppleViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
}
