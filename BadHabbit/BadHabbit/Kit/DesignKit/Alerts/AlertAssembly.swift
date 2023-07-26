//
//  AlertAssembly.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 21.07.23.
//

import UIKit

protocol AlertAssemblyProtocol {
    func alert(
        for error: Error,
        actionHandler: VoidClosure?
    ) -> PresentableAlertProtocol
    
    func alert(
        with configuration: AlertConfiguration
    ) -> PresentableAlertProtocol
}

extension AlertAssemblyProtocol {
    func alert(
        for error: Error
    ) -> PresentableAlertProtocol {
        alert(for: error, actionHandler: nil)
    }
}

class AlertAssembly: AlertAssemblyProtocol {
    
    private let globalCoordinator: IGlobalCoordinator
    
    init(globalCoordinator: IGlobalCoordinator) {
        self.globalCoordinator = globalCoordinator
    }
}

extension AlertAssembly {
    func alert(for error: Error, actionHandler: VoidClosure? = nil) -> PresentableAlertProtocol {
        alert(
            with: AlertConfiguration(
                title: error.localizedDescription,
                actions: [AlertAction.ok()]
            )
        )
    }
    
    func alert(with configuration: AlertConfiguration) -> PresentableAlertProtocol {
        let router = AlertRouter(globalCoordinator: globalCoordinator)
        let presenter = AlertPresenter(router: router, title: configuration.title, message: configuration.message)
        
        let view = AlertController(presenter: presenter)
        
        router.view = view
        presenter.view = view
        
        configuration.actions?.forEach(presenter.addAction)
        
        return presenter
    }
}
