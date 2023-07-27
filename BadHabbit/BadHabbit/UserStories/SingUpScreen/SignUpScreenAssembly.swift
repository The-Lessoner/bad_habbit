//
//  SignUpScreenAssembly.swift
//  BadHabbit
//
//  Created by Viktoria Misiulia on 27/07/2023.
//

import UIKit

class SignUpScreenAssembly: StoryAssembly {
    private let alertAssembly: AlertAssemblyProtocol
    private let globalCoordinator: IGlobalCoordinator
    
    init(alertAssembly: AlertAssemblyProtocol, globalCoordinator: IGlobalCoordinator) {
        self.alertAssembly = alertAssembly
        self.globalCoordinator = globalCoordinator
    }
    
    func assembleStory() -> UIViewController {
        let router = SignUpScreenRouter(
            nextScreen: FillingPersonalDataAssembly(alertAssembly: alertAssembly),
            globalCoordinator: globalCoordinator)
        let presenter = SignUpScreenPresenter(router: router)
        let view = SignUpViewController(presenter: presenter)
        
        presenter.view = view
        
        return view
    }
}
