//
//  PresentableAlert.swift
//  BadHabbit
//
//  Created by Nikita Gayko on 21.07.23.
//

import UIKit

protocol PresentableAlertProtocol {
    func present(on presenter: CanPresentView?, completion: VoidClosure?)
}

extension PresentableAlertProtocol {
    func present() {
        present(on: nil, completion: nil)
    }
    
    func present(on presenter: CanPresentView) {
        present(on: presenter, completion: nil)
    }
}

protocol AlertPresenterProtocol {
    var title: String? { get }
    var message: String? { get }
}

final class AlertPresenter: AlertPresenterProtocol & PresentableAlertProtocol {
    
    let title: String?
    let message: String?
    
    var view: AlertControllerViewProtocol?
    private let router: AlertRouterProtocol
    
    init(router: AlertRouterProtocol, title: String?, message: String?) {
        self.router = router
       
        self.title = title
        self.message = message
    }
    
    func present(on presenter: CanPresentView?, completion: VoidClosure?) {
        router.present(on: presenter, animated: true, completion: completion)
    }
    
    func addAction(_ action: AlertAction) {
        view?.addAction(action)
    }
}
