//
//  AlertRouter.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 21.07.23.
//

import UIKit

protocol AlertRouterProtocol {
    func present(on presenter: CanPresentView?, animated: Bool, completion: VoidClosure?)
}

extension AlertRouterProtocol {
    func present(on presenter: CanPresentView?) {
        present(on: presenter, animated: true, completion: nil)
    }
}

class AlertRouter: AlertRouterProtocol {
    
    weak var view: UIViewController?
    private let globalCoordinator: IGlobalCoordinator
    
    init(
        globalCoordinator: IGlobalCoordinator
    ) {
        self.globalCoordinator = globalCoordinator
    }
    
    func present(on presenter: CanPresentView?, animated: Bool, completion: VoidClosure?) {
        guard let view = view else { return }
        
        if let presenter = presenter {
            presenter.present(view)
        } else {
            globalCoordinator.presentOnTopVisibleViewController(
                view,
                animated: animated,
                completion: completion
            )
        }
    }
}
