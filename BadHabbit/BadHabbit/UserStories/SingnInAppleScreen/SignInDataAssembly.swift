//
//  SignInDataAssembly.swift
//  BadHabbit
//
//  Created by Halina Kurylchykava on 24.07.23.
//

import UIKit

class SignInDataAssembly: StoryAssembly {
    
    private let alertAssembly: AlertAssemblyProtocol
    private let globalCoordinator: IGlobalCoordinator
    
    init(alertAssembly: AlertAssemblyProtocol, globalCoordinator: IGlobalCoordinator) {
        self.alertAssembly = alertAssembly
        self.globalCoordinator = globalCoordinator
    }
    
    func assembleStory() -> UIViewController {
        let router = SignInDataRouter(nextScreen: FillingPersonalDataAssembly(alertAssembly: alertAssembly), globalCoordinator: globalCoordinator)
        let presenter = SignInDataPresenter(router: router)
        let view = SignInAppleViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
    
}
